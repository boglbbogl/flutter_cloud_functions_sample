
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const mkdirp = require("mkdirp");
const spawn = require("child-process-promise").spawn;
const path = require("path");
const os = require("os");
const fs = require("fs");
const nodemailer = require("nodemailer")
const gmailEmail = functions.config().gmail.email;
const gmailPassword = functions.config().gmail.password;
admin.initializeApp();

const JPEG_EXTENSION = ".jpg";

exports.updateUser = functions.region("asia-northeast3").firestore.document("users/{uid}").onUpdate(async (snapshot, context) => {
    const name = snapshot.after.data();
    await admin.firestore().doc(`profiles/${context.params.uid}`).update({
        "name": name.name,
    });
});

exports.createProfile = functions.region("asia-northeast3").firestore.document("users/{uid}").onCreate(async (snapshot) => {
    const {
        email, uid, name, createdAt,
    } = snapshot.data();
    await admin.firestore().doc(`profiles/${uid}`).set({
        "uid": uid,
        "email": email,
        "name": name,
        "createdAt": createdAt,
        "age": null,
        "address": null,
        "followers": [],
        "followings": [],
    });
    return null;
});

exports.createUserWithWelcomeEmail = functions.region("asia-northeast3").auth.user().onCreate(async (user) => {
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: gmailEmail,
            pass: gmailPassword,
        },
    });

    const mailOptions = {
        from: gmailEmail,
        to: user.email,
        subject: "Welcome To My App!",
        text: `Hey ${user.displayName || ""}! Welcome to My App. I hope you will enjoy our service.`,
    };

    try {
        await transporter.sendMail(mailOptions);
        functions.logger.log(
            `New Welcom email sent to: ${user.email}`,
            user.email,
        );
    } catch (error) {
        functions.logger.error(
            `There was an error while sending the email: ${user.email}`,
            error,
        );
    }
});

exports.imageToJPG = functions.region("asia-northeast3").storage.object().onFinalize(async (object) => {
    const filePath = object.name;
    const baseFileName = path.basename(filePath, path.extname(filePath));
    const fileDir = path.dirname(filePath);
    const JPEGFilePath = path.normalize(path.format({
        dir: fileDir, name: baseFileName, ext: JPEG_EXTENSION,
    }));
    const tempLocalFile = path.join(os.tmpdir(), filePath);
    const tempLocalDir = path.dirname(tempLocalFile);
    const tempLocalJPEGFile = path.join(os.tmpdir(), JPEGFilePath);

    if (!object.contentType.startsWith("image/")) {
        functions.logger.log("This is not an image.");
        return null;
    }

    if (object.contentType.startsWith("image/jpeg")) {
        functions.logger.log("Already a JPEG.");
        return null;
    }

    const bucket = admin.storage().bucket(object.bucket);
    await mkdirp(tempLocalDir);
    await bucket.file(filePath).download({
        destination: tempLocalFile,
    });
    functions.logger.log("The file has been downloaded to", tempLocalFile);
    await spawn("convert", [tempLocalFile, tempLocalJPEGFile]);
    functions.logger.log("JPEG image created at", tempLocalJPEGFile);
    await bucket.upload(tempLocalJPEGFile, {
        destination: JPEGFilePath,
    });
    functions.logger.log("JPEG image uploaded to Storage at", JPEGFilePath);
    fs.unlinkSync(tempLocalJPEGFile);
    fs.unlinkSync(tempLocalFile);
    return null;
});

exports.helloWorld = functions.region("asia-northeast3").https.onRequest((request, response) => {
    response.send("Hello from Firebase!");
});
