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
          builder: (context) => mainScreen(),
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextField(
                controller: tfemail,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                child: TextField(
                  controller: tfpassword,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
              ),
            ),
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
