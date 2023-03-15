import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
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
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 34,
                  color: Colors.white,

                ),
              ),

              SizedBox(height: 23.0),

              CircularProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.transparent,
                semanticsLabel: 'Circular progress indicator',
              )
            ]
          ),
        ),
      )
    );
  }
}

