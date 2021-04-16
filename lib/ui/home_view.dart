import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobs_app2/model/AdState.dart';
import 'package:jobs_app2/ui/MainDrawer.dart';
import 'package:jobs_app2/ui/addnewjobs.dart';
import 'package:jobs_app2/ui/errorpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd banner;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adstate = Provider.of<AdState>(context);
    adstate.initialization.then((status) {
      setState(
        () {
          banner = BannerAd(
              size: AdSize.banner,
              adUnitId: adstate.banneradunit,
              request: AdRequest(),
              listener: adstate.adListener)
            ..load();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City Jobs"),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                        children: snapshot.data.docs.map((document) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 350.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(FontAwesome.user),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Hr Name:${document.data()['Hr_Name']}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.phone),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Hr ContactInfo:${document.data()['Hr_Contactinfo']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.info_circle),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Job Details:${document.data()['Job_details']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.bars),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Vacancy:${document.data()['Vacancy']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.money),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Salary:${document.data()['Salary']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.search_plus),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Job Locations:${document.data()['Job_location']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(FontAwesome.hourglass_1),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Part or Full time:${document.data()['partorfull']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        MaterialButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_circle_outline_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Apply On the Number Provided!",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          color: Colors.blueAccent,
                                          onPressed: () {},
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
                  ),
                  if (banner == null)
                    SizedBox(
                      height: 50,
                    )
                  else
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: AdWidget(ad: banner),
                    )
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNewJob()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
