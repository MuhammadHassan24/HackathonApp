import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/home_view.dart';

class Signup_View extends StatefulWidget {
  const Signup_View({super.key});

  @override
  State<Signup_View> createState() => _Signup_ViewState();
}

class _Signup_ViewState extends State<Signup_View> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final paswordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final lastdatecontroller = TextEditingController();

  registeruser() async {
    try {
      UserCredential Credentialuser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: paswordcontroller.text,
      );
      String? uid = Credentialuser.user?.uid;
      if (uid != null) {
        adddataonfirestore(uid);

        emailcontroller.clear();
        namecontroller.clear();
        paswordcontroller.clear();
        addresscontroller.clear();
        numbercontroller.clear();
        lastdatecontroller.clear();
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home_View()));
      emailcontroller.clear();
      paswordcontroller.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  adddataonfirestore(String uid) {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": emailcontroller.text,
      "role": selectedRole,
      "name": namecontroller.text,
      "address": addresscontroller.text,
      "number": numbercontroller.text,
      "lastdate": lastdatecontroller.text,
      // "blood_G": _selectedRole,
      "id": uid,
    });
  }

  registeralert() {
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

  String? numbervalidat(value) {
    if (value.isEmpty) {
      return "Please Enter Your Phone Number";
    }
    if (value.length <= 10) {
      return "Please Enter Valid Phone Number";
    }
    return null;
  }

  String selectedRole = "Donor";
  List<String> roleOptions = ["Donor", "Maneger"];
  // String _selectedRole = "A+";
  // List<String> _roleOptions = [
  //   "O-",
  //   "O+",
  //   "A+",
  //   "B+",
  //   "A-",
  //   "AB-",
  //   "AB+",
  //   "B-"
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            color: Color(0xffEB3738),
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
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: paswordcontroller,
                        validator: passwordvalidat,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: validatemail,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Address";
                          }
                          return null;
                        },
                        controller: addresscontroller,
                        decoration: InputDecoration(
                          labelText: "Address",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: numbervalidat,
                        controller: numbercontroller,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2030));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              lastdatecontroller.text = formattedDate;
                            });
                          }
                        },
                        controller: lastdatecontroller,
                        decoration: InputDecoration(
                          labelText: "Last Donation Date",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   width: 200,
                      //   child: DropdownButtonFormField<String>(
                      //     value: _selectedRole,
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         _selectedRole = newValue!;
                      //       });
                      //     },
                      //     items: _roleOptions.map((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          value: selectedRole,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRole = newValue!;
                            });
                          },
                          items: roleOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffEB3738)),
                            onPressed: () {
                              registeralert();
                              registeruser();
                            },
                            child: Text("SignUP")),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
