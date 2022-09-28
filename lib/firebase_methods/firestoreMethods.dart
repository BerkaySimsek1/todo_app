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
        deneme: false,
      );

      await createOrUpdateUserData(tasks.getDataMap());
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> updatee(bool isChecked, String path) async {
    User? user = await Auth().currentuser;

    DocumentReference ref = await FirebaseFirestore.instance
        .collection("task")
        .doc(user!.uid)
        .collection("task")
        .doc(path);
    return ref.update({'deneme': isChecked});
  }

  createOrUpdateTaskImportant(
      Map<String, dynamic> userDataMap, String path) async {
    User? user = await Auth().currentuser;
    DocumentReference ref = FirebaseFirestore.instance
        .collection("task")
        .doc(user!.uid)
        .collection("importance")
        .doc(path);
    return ref.set(userDataMap);
  }

  void valideAndSubmitImportance(
      String task, String description, String path) async {
    try {
      Task tasks = Task(
        task: task,
        description: description,
        deneme: true,
      );

      await createOrUpdateTaskImportant(tasks.getDataMap(), path);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> delete(String path) async {
    User? user = await Auth().currentuser;

    DocumentReference ref = await FirebaseFirestore.instance
        .collection("task")
        .doc(user!.uid)
        .collection("importance")
        .doc(path);
    return ref.delete();
  }
}
