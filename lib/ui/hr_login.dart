import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobs_app2/net/flutterfire.dart';
import 'package:permission_handler/permission_handler.dart';

class HrLogin extends StatefulWidget {
  @override
  _HrLoginState createState() => _HrLoginState();
}

class _HrLoginState extends State<HrLogin> {
  TextEditingController _hrNameController = TextEditingController();
  TextEditingController _hrcontactController = TextEditingController();
  TextEditingController _hremailController = TextEditingController();
  String imageUrl;
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

  Future<bool> addHrUser(
    String hrname,
    String hrcontactinfo,
    String email,
  ) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('HR_user').doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          "UserType": "HR",
          "Hr_Name": hrname,
          "Hr_contactinfo": hrcontactinfo,
          "email": email
        });

        return true;
      }
    });
  }

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
                      controller: _hrNameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "HR_Contact Info",
                          labelStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      controller: _hrcontactController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "HR_Email",
                          labelStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      controller: _hremailController,
                    ),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addHrUser(_hrNameController.text,
            _hrcontactController.text, _hremailController.text),
        child: Icon(Icons.add),
      ),
    );
  }
}
