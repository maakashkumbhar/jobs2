import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jobs_app2/ui/newlogger.dart';

import 'UserView.dart';
import 'home_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Hr_Users')
            .doc(uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }
          if (snapshot.data['type'] == 'Hr') {
            _navigateToHr(context);
          }
          if (snapshot.data['type'] == 'User') {
            _navigateToNormalUser(context);
          }
          return CircularProgressIndicator();
          //switch (snapshot.connectionState) {
          // case ConnectionState.waiting:
          //  return CircularProgressIndicator();
          //default:
          // return checkRole(snapshot.data, context);
          //}
        },
      ),
    );
  }
}

_navigateToHr(BuildContext context) {
  Navigator.of(context).pushNamed('/HomeScreen');
}

_navigateToNormalUser(BuildContext context) {
  Navigator.of(context).pushNamed('/NormalUser');
}
