import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app2/ui/hr_login.dart';
import 'package:jobs_app2/ui/my_jobs.dart';

import 'package:jobs_app2/ui/home_view.dart';
import 'package:jobs_app2/ui/newlogin.dart';
import 'package:jobs_app2/ui/splash_screnn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Jobs',
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',
      routes: {
        '/Authentication': (context) => GlassMorphism(),
        '/HomeScreen': (context) => Home(),
        '/SplashScreen': (context) => Splash_screen(),
        '/MyJobs': (context) => MyJobs(),
        '/HrLogin': (context) => HrLogin()
      },
      home: Home(),
    );
  }
}
