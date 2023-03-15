import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

