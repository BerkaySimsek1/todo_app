import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/screens/addTaskScreen.dart';
import 'package:todo_app/screens/signinScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  bool isChecked = false;
  bool isImp = false;
  void checkControl(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  void impControl() {
    setState(() {
      isImp = !isImp;
    });
  }

  Future<void> logOut() async {
    await Auth().signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => signInScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () {}, child: Text("Important")),
          TextButton(
              onPressed: () {
                logOut();
              },
              child: Text("Log out")),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("task")
            .doc(Auth().currentuser!.uid)
            .collection("task")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!.docs.map(
              (task) {
                return ListTile(
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      checkControl(value!);
                    },
                  ),
                  title: Text(
                    task["task"],
                    style: TextStyle(
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  trailing: GestureDetector(
                      onTap: () => impControl(),
                      child: Icon(
                        Icons.label_important,
                        color: isImp ? Colors.red : Colors.grey[350],
                      )),
                );
              },
            ).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddtaskScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
