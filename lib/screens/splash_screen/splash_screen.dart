import 'dart:async';
import 'package:flutter/material.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/index/index_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_splash.dart';

class SplashScreen extends StatefulWidget {
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2;
  final Repository httpService = Repository();
  final Color backgroundColor = Color(0xFFECECFE);

  late Auth _auth;
  @override
  void initState() {
    super.initState();
    _loadWidget();
    // httpService.empresas();
    _auth = Auth();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();

    Provider.of<Auth>(context, listen: false)
        .setUserId(prefs.getString('userId') ?? '');

    if (prefs.containsKey("token") || prefs.containsKey("userId")) {
      _auth.autoLogin().then((value) => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => IndexScreen())));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OnBoardingSplash())); //Here
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFFECECFE),
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                        color: backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: size.height * 0.18),
                            Container(
                              height: size.height * 0.5,
                              width: size.width * 0.8,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/splash/splash_copy.png')),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
