import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app2/ui/home_view.dart';

class GlassMorphism extends StatefulWidget {
  @override
  _GlassMorphismState createState() => _GlassMorphismState();
}

class _GlassMorphismState extends State<GlassMorphism> {
  TextEditingController _emailField = TextEditingController();

  TextEditingController _passwordField = TextEditingController();

  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      showError(e.message);
      print(e);
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The Password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Ther account already exists for that email.');
      }
      return false;
    } catch (e) {
      showError(e.message);
      print(e);
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 24,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.2),
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Container(
                  height: 500,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Login Here!',
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _emailField,
                          decoration: InputDecoration(
                              hintText: "Something@email.com",
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: "Email",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _passwordField,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password here!",
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: "Password",
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 45,
                        child: MaterialButton(
                            onPressed: () async {
                              bool shouldNavigate = await signIn(
                                  _emailField.text, _passwordField.text);
                              if (shouldNavigate) {
                                //Navigate
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ));
                              } else {
                                //Add Somthing for the else part like a 404 page
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 45,
                        child: MaterialButton(
                          onPressed: () async {
                            bool shouldNavigate = await register(
                                _emailField.text, _passwordField.text);
                            if (shouldNavigate) {
                              //Navigate
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ));
                            } else {
                              //Add Somthing for the else part like a 404 page
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
