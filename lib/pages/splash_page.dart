import 'dart:async';
import 'package:alapu/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:alapu/utils/color.dart';

import 'regi_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //     colors: [orangeColors, orangeLightColors],
              //     end: Alignment.bottomCenter,
              //     begin: Alignment.topCenter),
            ),
            child: Center(
              child: Image.asset(
                "assets/alap_logo.png",
                width: 300,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/up.png",
              width: 150,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/down.png",
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
