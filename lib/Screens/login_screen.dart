import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/signup_screen.dart';
import 'package:todo_app/home_view.dart';

class Login_View extends StatefulWidget {
  const Login_View({super.key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  final _formkey = GlobalKey<FormState>();

  final emailcontrollor = TextEditingController();

  final paswordcontrollor = TextEditingController();

  loginuser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontrollor.text,
        password: paswordcontrollor.text,
      );
      print("Login Ho gaya");
      emailcontrollor.clear();
      paswordcontrollor.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_View()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEB3738),
      body: Stack(
        children: [
          Container(
            height: 300,
            child: Center(
                child: Container(
                    height: 100,
                    child: Image.asset(
                      "assets/images/Group 155.png",
                    ))),
          ),
          Center(
            child: Container(
              height: 350,
              width: 280,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                validator: validatemail,
                                controller: emailcontrollor,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: passwordvalidat,
                              controller: paswordcontrollor,
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: BeveledRectangleBorder(),
                                    backgroundColor: Color(0xffEB3738),
                                  ),
                                  onPressed: () async {
                                    useralert();
                                    await loginuser();
                                  },
                                  child: Text("Login")),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup_View()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color(0xffEB3738),
                                  ),
                                ))
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  useralert() {
    if (_formkey.currentState!.validate()) {}
  }

  String? validatemail(value) {
    if (value!.isEmpty) {
      return "Please Enter Your Email";
    }
    RegExp emailregexp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailregexp.hasMatch(value)) {
      return "Please Enter Valid Email";
    }
    return null;
  }

  String? passwordvalidat(value) {
    if (value.isEmpty) {
      return "Please Enter Your Email";
    }
    if (value.length < 8) {
      return "Please Enter 8 Digit Password";
    }
    return null;
  }
}
