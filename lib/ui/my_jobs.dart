import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyJobs extends StatefulWidget {

  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<MyJobs> {

  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs!'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('User_id', isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "No Data",
              style: TextStyle(fontSize: 20),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data.docs[index].data();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hr Name : ${doc['Hr_Name']}",
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Hr ContactName :${doc['Hr_Contactinfo']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Job Details :${doc['Job_details']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Vacancy : ${doc['Vacancy']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Salary : ${doc['Salary']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Job Location : ${doc['Job_location']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Part/Full Time : ${doc['partorfull']}",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              snapshot.data.docs[index].reference.delete();
                            },
                            child: Text(
                              'Delete Job',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
