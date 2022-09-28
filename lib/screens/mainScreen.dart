import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/firebase_methods/firestoreMethods.dart';
import 'package:todo_app/screens/addTaskScreen.dart';
import 'package:todo_app/screens/importanceScreen.dart';
import 'package:todo_app/screens/signinScreen.dart';

class mainScreen extends StatefulWidget {
  mainScreen({super.key, required this.isImp});
  bool isImp;

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => importanceScreen(),
                    ));
              },
              child: Text("Important")),
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
                return customListTile(
                  path: task.id.toString(),
                  text: task["task"],
                  isChecked: task["deneme"],
                  desc: task["description"],
                  isImp: widget.isImp,
                );
              },
            ).toList());
          } else {
            return const Center(
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

class customListTile extends StatefulWidget {
  customListTile({
    Key? key,
    required this.text,
    required this.isChecked,
    required this.path,
    required this.desc,
    required this.isImp,
  }) : super(key: key);
  String text;
  bool isChecked, isImp;
  String path, desc;
  @override
  State<customListTile> createState() => _customListTileState();
}

class _customListTileState extends State<customListTile> {
  @override
  Widget build(BuildContext context) {
    void deneme1(bool value, String path) {
      setState(() {
        firestoreMethods().updatee(value, path);
      });
    }

    return ListTile(
      leading: Checkbox(
        value: widget.isChecked,
        onChanged: (value) {
          deneme1(value!, widget.path);
        },
      ),
      title: Text(
        widget.text,
        style: TextStyle(
            decoration: widget.isChecked
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: GestureDetector(
          onTap: () {
            setState(() {
              widget.isImp = !widget.isImp;
            });
            widget.isImp
                ? firestoreMethods().valideAndSubmitImportance(
                    widget.text, widget.desc, widget.path)
                : firestoreMethods().delete(widget.path);
          },
          child: Icon(
            Icons.label_important,
            color: widget.isImp ? Colors.red : Colors.grey[350],
          )),
    );
  }
}
