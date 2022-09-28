import 'package:flutter/material.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/screens/mainScreen.dart';
import 'package:todo_app/screens/signupScreen.dart';

class signInScreen extends StatefulWidget {
  const signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signScreenState();
}

class _signScreenState extends State<signInScreen> {
  TextEditingController tfemail = TextEditingController();
  TextEditingController tfpassword = TextEditingController();

  Future<void> signIn() async {
    await Auth().signIn(email: tfemail.text, password: tfpassword.text);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => mainScreen(
            isImp: false,
          ),
        ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(
              textEditingController: tfemail,
              keyboardtype: TextInputType.emailAddress,
              text: "E-mail",
              isPassword: false,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: customTextField(
                  textEditingController: tfpassword,
                  keyboardtype: TextInputType.text,
                  text: "Password",
                  isPassword: true,
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.40,
                child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text("Sign in"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signUpScreen(),
                          ));
                    },
                    child: Text("Sign up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class customTextField extends StatelessWidget {
  customTextField(
      {Key? key,
      required this.textEditingController,
      required this.keyboardtype,
      required this.text,
      required this.isPassword})
      : super(key: key);

  bool isPassword;
  TextEditingController textEditingController;
  String text;
  TextInputType keyboardtype;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: text,
        ),
        keyboardType: keyboardtype,
        obscureText: isPassword,
      ),
    );
  }
}
