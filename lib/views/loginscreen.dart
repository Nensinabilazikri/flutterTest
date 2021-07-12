// import 'file:///C:/Users/XSIS%20Bootcamp/AndroidStudioProjects/flutter_app/lib/components/custom_alert_dialog.dart';
import 'package:Nensi/utilities/google_api.dart';
import 'package:Nensi/utilities/shared_preferences.dart';
import 'package:Nensi/components/custom_alert_dialog.dart';

import 'package:Nensi/viewmodels/login_user_viewmodel.dart';
import 'package:Nensi/views/listmahasiswascreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'inputdatamahasiswascreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  String username = '';
  String password = '';
  List<Color> gradients = [
    Color.fromRGBO(255, 189, 148, 1.0),
    Color.fromRGBO(241, 195, 163, 1.0),
  ];

  final TextEditingController _controllerUsername = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //mengetahui ukuran layar
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Scaffold(
        //mencegah height berubah saat keyboard muncul
        resizeToAvoidBottomInset: false,

        body: GestureDetector(
          onTap: () {
            //ini untuk menghilangkan keyboard
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration:
                BoxDecoration(color: Color.fromRGBO(217, 175, 205, 1.0)),
            width: size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150.0,
                  ),
                  Text(
                    'Login here',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 50,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'ChampagneLimousines'),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  //   child: Material(
                  //       elevation: 2.0,
                  //       color: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(40.0)),
                  //       child: Padding(
                  //           padding: EdgeInsets.only(
                  //               left: 20, right: 20, top: 10, bottom: 10),
                  //           child: TextField(
                  //             controller: _controllerUsername,
                  //             decoration: InputDecoration(
                  //                 border: InputBorder.none,
                  //                 hintText: 'Email',
                  //                 hintStyle: TextStyle(color: Colors.grey)),
                  //             onChanged: (value) {
                  //               username = value;
                  //               //set value
                  //             },
                  //           ))),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  //   child: Material(
                  //     elevation: 2.0,
                  //     color: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(40.0)),
                  //     child: Padding(
                  //         padding: EdgeInsets.only(
                  //             left: 20, right: 20, top: 10, bottom: 10),
                  //         child: TextField(
                  //           controller: _controllerPassword,
                  //           decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: 'Password',
                  //               hintStyle: TextStyle(color: Colors.grey)),
                  //           onChanged: (value) {
                  //             password = value;
                  //             //set value
                  //           },
                  //           obscureText: true,
                  //         )),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(0, 4, 0, 18),
                  //   child: CheckboxListTile(
                  //     title: Text(
                  //       'Remember Me',
                  //       style: TextStyle(fontSize: 14, color: Colors.black54),
                  //     ),
                  //     value: isRememberMe,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         isRememberMe = newValue;
                  //       });
                  //     },
                  //     controlAffinity: ListTileControlAffinity.leading,
                  //   ),
                  // ),
                  TextButton(
                      // style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all(
                      //         Color.fromRGBO(250, 183, 137, 1.0))),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          gradient: LinearGradient(
                              colors: gradients,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: Text(
                          "Login with Google",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        googleIn();
                      }),

                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ListScreen();
                        }));
                      },
                      child: Text(
                        'without sign in',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ))
                  // InkWell(
                  //   child: Text(
                  //     'Register',
                  //     style: TextStyle(
                  //       fontStyle: FontStyle.italic,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black54,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     pindahKeRegisterScreen(context);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    SharePreferencesHelper.readIsRemember().then((isremember) {
      if (isremember) {
        SharePreferencesHelper.readUsername().then((value) {
          setState(() {
            username = value;

            _controllerUsername.text = value;
          });
        });
        SharePreferencesHelper.readPassword().then((value) {
          setState(() {
            password = value;

            _controllerPassword.text = value;
          });
        });
      }
    });
  }

  // void pindahKeRegisterScreen(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return RegisterScreen();
  //   }));
  // }

  Future googleIn() async {
    final akun = await GoogleSignInApi.login();

    if (akun == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in failed, Try again!')));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ListScreen(akun: akun),
      ));
    }
  }
}
