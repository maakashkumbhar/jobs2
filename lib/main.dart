import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jobs_app2/model/AdState.dart';
import 'package:jobs_app2/ui/hr_login.dart';
import 'package:jobs_app2/ui/my_jobs.dart';

import 'package:jobs_app2/ui/home_view.dart';
import 'package:jobs_app2/ui/newlogger.dart';
import 'package:jobs_app2/ui/splash_screnn.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initFuture = MobileAds.instance.initialize();
  final adstate = AdState(initFuture);
  runApp(Provider.value(
    value: adstate,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Jobs',
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',
      routes: {
        '/Authentication': (context) => LoginPage(),
        '/HomeScreen': (context) => Home(),
        '/SplashScreen': (context) => Splash_screen(),
        '/MyJobs': (context) => MyJobs(),
        '/HrLogin': (context) => HrLogin()
      },
      home: Home(),
    );
  }
}
