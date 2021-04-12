import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HrLogin extends StatefulWidget {
  @override
  _HrLoginState createState() => _HrLoginState();
}

class _HrLoginState extends State<HrLogin> {
//////////////////////////////

//////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HR_Login")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "HR_Name",
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "HR_Contact Info",
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "HR_Email",
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Please Provide with a Photo Identity Proof!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    child: Center(
                      child: Row(
                        children: [
                          Icon(FontAwesome.image),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Upload Image"),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
