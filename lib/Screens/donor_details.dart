import 'package:flutter/material.dart';
import 'package:todo_app/Screens/update_donordetail.dart';

class Donor_Details extends StatefulWidget {
  final Map<String, dynamic> donorData;
  const Donor_Details({super.key, required this.donorData});

  @override
  State<Donor_Details> createState() => _Donor_DetailsState();
}

class _Donor_DetailsState extends State<Donor_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEB3738),
        elevation: 0,
        title: Text("DONOR DETAILS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 2))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(widget.donorData["name"])
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 2))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(widget.donorData["address"])
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 2))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Phone",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(widget.donorData["number"])
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 2))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Last Donation Date",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(widget.donorData["lastdate"])
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Blood Group",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          height: 20,
                          width: 30,
                          color: Color(0xffEB3738),
                          child: Center(
                              child: Text(
                            widget.donorData["blood_G"],
                            style: TextStyle(fontSize: 15),
                          ))),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all( 20),
                  child: Container(
                    height: 175,
                    width: 280,
                    child: Image.asset("assets/images/Mask group (1).png"),
                  ),
                ),
                Center(
                  child: Container(
                    
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor:  Color(0xffEB3738)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Update_Detail(donordetail: widget.donorData)));
                                      setState(() {
                                        
                                      });
                        },
                        child: Text("EDIT")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
