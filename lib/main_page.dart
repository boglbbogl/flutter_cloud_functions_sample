import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Functions Sample",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          _button(
            context: context,
            title: "Create User",
            onTap: () async {
              UserCredential credential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: "abc@gmail.com", password: "123123");
              if (credential.user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(credential.user!.uid)
                    .set({
                  "uid": credential.user!.uid,
                  "email": credential.user!.email,
                  "name": credential.user!.displayName,
                  "createdAt": Timestamp.now(),
                });
              }
            },
          ),
          _button(
            context: context,
            title: "Update User",
            onTap: () async {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .update({
                  "name": "abc",
                });
              }
            },
          ),
          _button(
            context: context,
            title: "Delete User",
            onTap: () async {
              UserCredential credential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: "abc@gmail.com", password: "123123");
              if (credential.user != null) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(credential.user!.uid)
                    .set({
                  "uid": credential.user!.uid,
                  "email": credential.user!.email,
                  "name": credential.user!.displayName,
                  "createdAt": Timestamp.now(),
                });
              }
            },
          ),
        ],
      ),
    );
  }

  GestureDetector _button({
    required BuildContext context,
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        )),
      ),
    );
  }
}
