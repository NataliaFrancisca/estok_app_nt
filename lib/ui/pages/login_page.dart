import 'package:flutter/material.dart';
import 'package:estok_app/colors.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/validator/login_validator.dart';
import 'package:estok_app/ui/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginValidator{
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _focusLogin = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "ESTOK APP",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 34,
                      color: AppColors.blackTextColor,
                    ),
                  ),

                  SizedBox(height: 23.0),

                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: AppColors.blackTextColor,
                    ),
                  ),

                  SizedBox(height: 54.0),

                  CustomTextFormField(
                    controller: _loginController,
                    labelText: 'E-mail',
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    inputIcon: Icon(Icons.person, size: 22, color: AppColors.iconPrimaryColor),
                    validator: validateLogin,
                    focusNode: _focusLogin,
                    nextFocus: _focusPassword,
                    previousFocus: _focusLogin,
                  ),

                  SizedBox(height: 20.0),

                  CustomTextFormField(
                    controller: _passwordController,
                    labelText: 'Senha',
                    hintText: 'Senha',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    inputIcon: Icon(Icons.lock, size: 22, color: AppColors.iconPrimaryColor),
                    focusNode: _focusPassword,
                    previousFocus: _focusLogin,
                    validator: validatePassword
                  ),

                  SizedBox(height: 38.0),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          _loginOnPressed(context);
                        },
                        child: Text(
                          'Entrar'.toUpperCase(),
                          style: TextStyle(fontSize: 15,
                          color: AppColors.blackTextColor)
                        ),

                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10, vertical: 16)),
                          backgroundColor: MaterialStateProperty.all(AppColors.lightPurpleColor),
                        )
                    )
                  ),
                ],
              )
              ),
          )

        ),
      )
    );
  }

  void _loginOnPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) {
      return;
    }

    UserModel.of(context).login(_loginController.text, _passwordController.text,
      onSuccess: () {
        Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Usuário logado com sucesso!",
          onPop: (value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        );
        return;
      },
      onFail: (String message) {
        Message.onFail(
          scaffoldKey: _scaffoldKey,
          message: message,
          onPop: (value){
            print("Algo de errado com o login, tente novamente!");
          }
        );
        return;
      });
  }
}
