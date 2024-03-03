import 'package:babymeal/etc/url.dart';
import 'package:babymeal/pages/NavigationPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'community/ViewCommunityPage.dart';
import 'mypage/ViewMyPage.dart';
import 'recommend/ViewRecommendPage.dart';
import 'refrigerator/ViewRefrigeratorPage.dart';
import 'scrab/ViewScrabPage.dart';

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({super.key});
  @override
  _StartPageWidgetState createState() => _StartPageWidgetState();
}

class _StartPageWidgetState extends State<StartPageWidget> {
  String? accessToken = "";

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString("access_token");

    if (accessToken != null) {
      print("토큰은 " + accessToken!);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NavigationPageWidget()));
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SigninSelectEmail()));
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xffFF5C39)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(right: 5),
              child: Image.asset(
                "assets/images/babymeal_logo.png",
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Image.asset(
                "assets/images/babymeal.png",
              ),
            ),
          ],
        )),
      ),
    );
  }
}
