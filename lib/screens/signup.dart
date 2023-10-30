import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/reusable/reusable.dart';
import 'package:hackathon/screens/home.dart';
import 'package:hackathon/util/color.dart';


class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  bool isPassword= true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "lib/images/signup.png",
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  inputTextField(
                      "Email", Icons.person_outline, false, emailTextController),
                  const SizedBox(
                    height: 20,
                  ),

              TextField(
                controller: passwordTextController,
                obscureText: isPassword,
                cursorColor: Colors.blue,
                style:  const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        if(isPassword==false){
                          isPassword = true;
                        } else {
                          isPassword =false;
                        }
                      },
                      );
                    },
                    child: Icon(isPassword ? Icons.visibility : Icons.visibility_off,),
                  ),
                  labelText: "Password",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),





                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailTextController.text,
                                password: passwordTextController.text);
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => home()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Email already is in use.')));
                        } else if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password is very weak.')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
