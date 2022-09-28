import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/firebase_methods/firestoreMethods.dart';
import 'package:todo_app/screens/mainScreen.dart';

class importanceScreen extends StatefulWidget {
  const importanceScreen({super.key});

  @override
  State<importanceScreen> createState() => _importanceScreenState();
}

class _importanceScreenState extends State<importanceScreen> {
  late bool impPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("task")
            .doc(Auth().currentuser!.uid)
            .collection("importance")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map((task) {
              return ListTile(
                title: Text(task["task"]),
                subtitle: Text(task["description"]),
                trailing: IconButton(
                    onPressed: () {
                      firestoreMethods().delete(task.id.toString());
                    },
                    icon: Icon(Icons.delete)),
              );
            }).toList());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
