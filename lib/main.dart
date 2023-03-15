import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:estok_app_natalia_francisca/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with AppColors{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estok App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.primaryColor,
      ),
        debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
