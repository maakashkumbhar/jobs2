import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobs_app2/net/flutterfire.dart';
import 'package:permission_handler/permission_handler.dart';

class Hr_register extends StatefulWidget {
  @override
  _HrLoginState createState() => _HrLoginState();
}

class _HrLoginState extends State<Hr_register> {
  String email, password, confirmpassword, contactinfo, username;
  String imageUrl;
  String User_type = 'Hr';
//////////////////////////////
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await _storage.ref().child('folderName/imageName').putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
//////////////////////////////

  ///////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("HR_Login")),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "HR_Contact Info",
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onChanged: (value) {
                          setState(() {
                            contactinfo = value;
                          });
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "HR_Email",
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });

                          obscureText:
                          true;
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Please Provide with a Photo Identity Proof!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      onPressed: () => uploadImage,
                    ),
                    RaisedButton(
                      child: Center(
                        child: Row(
                          children: [
                            Icon(FontAwesome.user),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Register Hr")
                          ],
                        ),
                      ),
                      onPressed: () => register_hrlogin(
                          username, contactinfo, email, password, User_type),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
