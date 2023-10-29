import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/login_screen.dart';

class LogOut_Screen extends StatefulWidget {
  const LogOut_Screen({super.key});

  @override
  State<LogOut_Screen> createState() => _LogOut_ScreenState();
}

class _LogOut_ScreenState extends State<LogOut_Screen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  String? address;
  String? number;
  String? role;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  Future<void> getCurrentUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection("users").doc(user.uid).get();

      if (userSnapshot.exists) {
        setState(() {
          name = userSnapshot["name"];
          address = userSnapshot["address"];
          number = userSnapshot["number"];
          role = userSnapshot["role"];
          isDataLoaded = true;
        });
      }
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Login_View();
        },
      ));
    } catch (e) {
      print("Error during signout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEB3738),
      ),
      body: isDataLoaded == false? Center(child: CircularProgressIndicator()):
       Stack(
        children: [
          Positioned(
            top: 170,
            right: 40,
            left: 40,
            child: Card(
              elevation: 10,
              child: Container(
                height: 250,
                width: 280,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  SizedBox(
                      height: 45,
                      child: Center(
                          child: Text(
                        "DONOR PROFILE",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ))),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 2))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$name",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 2))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$address",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 2))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$number",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
              top: 400,
              right: 80,
              left: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEB3738)),
                  onPressed: () {
                    logout();
                  },
                  child: Text("SignOut")))
        ],
      ),
    );
  }
}
