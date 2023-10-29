import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Update_Detail extends StatefulWidget {
  final Map<String, dynamic> donordetail;
  const Update_Detail({super.key, required this.donordetail});

  @override
  State<Update_Detail> createState() => _Update_DetailState();
}

class _Update_DetailState extends State<Update_Detail> {
  String selectedBG = "";
  TextEditingController? nameController;
  TextEditingController? addressController;
  TextEditingController? numberController;
  TextEditingController? lastdateController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.donordetail["name"]);
    addressController =
        TextEditingController(text: widget.donordetail["address"]);
    numberController =
        TextEditingController(text: widget.donordetail["number"]);
    lastdateController =
        TextEditingController(text: widget.donordetail["lastdate"]);
    selectedBG = widget.donordetail["blood_G"];
  }

  @override
  void dispose() {
    super.dispose();
    nameController?.dispose();
    addressController?.dispose();
    numberController?.dispose();
    lastdateController?.dispose();
  }

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  Future<void> updateUser() {
    return users
        .doc(widget.donordetail['id'])
        .update({
          'name': nameController?.text,
          'email': lastdateController?.text,
          "address": addressController?.text,
          "number": numberController?.text,
          "blood_G": selectedBG,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

 
  List<String> _roleOptions = [
    "O-",
    "O+",
    "A+",
    "B+",
    "A-",
    "AB-",
    "AB+",
    "B-"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffEB3738),
          title: Text("EDIT PROFILE"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                 
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: lastdateController,
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
                        lastdateController?.text = formattedDate;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: numberController,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: addressController,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Blood Group",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 60,
                      child: DropdownButton<String>(
                        elevation: 0,
                        value: selectedBG,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBG = newValue!;
                          });
                        },
                        items: _roleOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                      child: Container(
                    height: 40,
                    width: 140,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffEB3738)),
                        onPressed: () {
                          updateUser();
                        },
                        child: Text("SAVE")),
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
