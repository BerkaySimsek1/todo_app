import 'package:flutter/material.dart';
import 'package:todo_app/firebase_methods/firebaseMethods.dart';
import 'package:todo_app/screens/signinScreen.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signScreenState();
}

class _signScreenState extends State<signUpScreen> {
  TextEditingController tfemail = TextEditingController();
  TextEditingController tfpassword = TextEditingController();

  Future<void> signUp(String email, String password) async {
    await Auth().signUp(email: email, password: password);
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
                      signUp(tfemail.text, tfpassword.text);
                    },
                    child: Text("Sign up"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => signInScreen(),
                          ));
                      setState(() {});
                    },
                    child: Text("Sign in"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
