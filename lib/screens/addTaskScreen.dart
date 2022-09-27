import 'package:flutter/material.dart';
import 'package:todo_app/firebase_methods/firestoreMethods.dart';
import 'package:todo_app/screens/mainScreen.dart';
import 'package:todo_app/screens/signinScreen.dart';

class AddtaskScreen extends StatefulWidget {
  const AddtaskScreen({super.key});

  @override
  State<AddtaskScreen> createState() => _AddtaskScreenState();
}

class _AddtaskScreenState extends State<AddtaskScreen> {
  TextEditingController tfTask = TextEditingController();
  TextEditingController tfSubtitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(
                textEditingController: tfTask,
                keyboardtype: TextInputType.text,
                text: "Task"),
            customTextField(
                textEditingController: tfSubtitle,
                keyboardtype: TextInputType.text,
                text: "Description"),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.40,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        firestoreMethods()
                            .validateAndSubmit(tfTask.text, tfSubtitle.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mainScreen(),
                            ));
                      });
                    },
                    child: Text("Save")))
          ],
        ),
      ),
    );
  }
}
