import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jobs_app2/model/AdState.dart';
import 'package:jobs_app2/net/flutterfire.dart';
import 'package:jobs_app2/ui/newlogger.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
    return Container(
      color: Colors.white12,
      width: MediaQuery.of(context).size.width / 1.6,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/logo.png')),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Colors.white,
                  title: Text('Your Profile',
                      style: TextStyle(fontSize: 20.0, color: Colors.black)),
                  onTap: () {},
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/MyJobs');
                  },
                  title: Text(
                    'My Jobs',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  leading: Icon(
                    Icons.av_timer,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    'HR Login',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/HrLogin");
                  },
                  leading: Icon(
                    FontAwesome.user_plus,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    'LogOut',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  onTap: () {
                    signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 50,
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
            ),
          ),
        ],
      ),
    );
  }
}
