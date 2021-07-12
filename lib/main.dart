import 'package:Nensi/utilities/routes.dart';
import 'package:Nensi/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //lock screen orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluter test',
      // theme: ThemeData(
      //   primarySwatch: Colors.redAccent,
      // ),
      home: SplashScreen(),
      routes: {
        Routes.splashscreen: (context) => SplashScreen(),
      },
    );
  }
}
