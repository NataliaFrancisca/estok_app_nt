import 'package:flutter/material.dart';
import 'dart:async';

import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/pages/login_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ESTOK APP",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 23.0),

              Message.loading(context, color: Colors.white)
            ]
          ),
        ),
      )
    );
  }
}

