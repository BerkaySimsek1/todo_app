import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String task, String subtitle) async {
  CollectionReference user = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  user.add({
    "task": task,
    "subtitle": subtitle,
    "uid": uid,
  });
  return;
}
