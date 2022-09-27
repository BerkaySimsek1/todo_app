import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/notes/tasks.dart';

class firestoreMethods {
  createOrUpdateUserData(Map<String, dynamic> userDataMap) async {
    User? user = await Auth().currentuser;
    DocumentReference ref = FirebaseFirestore.instance
        .collection("task")
        .doc(user!.uid)
        .collection("task")
        .doc();
    return ref.set(userDataMap);
  }

  void validateAndSubmit(String task, String description) async {
    try {
      Task tasks = Task(
        task: task,
        description: description,
      );
      await createOrUpdateUserData(tasks.getDataMap());
    } catch (err) {
      print(err.toString());
    }
  }
}
