import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed: () {}, child: Text("Important"))],
        ),
        body: ListTile(
          leading: Checkbox(
            value: isChecked,
            onChanged: (value) {
              checkControl(value!);
            },
          ),
          title: Text(
            "Ders çalış",
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
        ));
  }
}
