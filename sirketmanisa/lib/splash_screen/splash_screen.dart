import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sirketmanisa/login/login.dart';
import 'package:sirketmanisa/screens/giris.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(showRegisterPage: () {}), // Ekstradan null değeri yerine bir fonksiyon geçildi
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery(data: MediaQueryData(), child: MaterialApp());
    return Scaffold(
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset("assets/gunes.json"),
              ),
            ],
          )),
    );
  }
}
//child:
