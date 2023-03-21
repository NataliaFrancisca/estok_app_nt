import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp(UserModel()));
}

class MyApp extends StatefulWidget with AppColors{
  final UserModel userScopedModel;

  MyApp(this.userScopedModel);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: widget.userScopedModel,
        child: MaterialApp(
        title: 'Estok App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          accentColor: AppColors.primaryColor,
        ),
          debugShowCheckedModeBanner: false,
        home: LoginPage()
      ),
    );
  }
}
