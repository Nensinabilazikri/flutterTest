import 'dart:async';
import 'package:Nensi/utilities/shared_preferences.dart';
import 'package:Nensi/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'inputdatamahasiswascreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 175, 205, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/test1.png',
              width: 180.0,
              height: 180.0,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 10, bottom: 20, left: 10)),
            Text(
              'To Do List',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'ChampagneLimousines'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Versi ',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              TextSpan(
                  text: '1.0 ',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontStyle: FontStyle.italic)),
              TextSpan(
                  text: ' by Nensi ',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ]))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //inisialisasi

    startSplashScreenDelay();
  }

  startSplashScreenDelay() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, callback);
  }

  void callback() {
    SharePreferencesHelper.readIsLogin().then((isLogin) {
      if (isLogin) {
        pindahDashboardScreen();
      } else {
        pindahLoginScreen();
      }
    });
  }

  void pindahLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }));
  }

  void pindahDashboardScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }));
  }
}

/*
import 'dart:async';

import 'package:Batch_256/views/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 175, 205, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/test1.png',
              width: 180.0,
              height: 180.0,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 10, bottom: 20, left: 10)),
            Text(
              'Batch 256 Flutter',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'BiomeRegular'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Versi ',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              TextSpan(
                  text: '1.0 ',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontStyle: FontStyle.italic))
            ]))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //inisialisasi

    startSplashScreenDelay();
  }

  startSplashScreenDelay() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, callback);
  }

  void callback() {
    //apakah sudah login?
    pindahLoginScreen();
  }

  void pindahLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }));
  }
}

 */
