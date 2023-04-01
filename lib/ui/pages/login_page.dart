import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:estok_app_natalia_francisca/ui/validator/login_validator.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginValidator{
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final FocusNode _focusSenha = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
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
                requestFocus: _focusSenha,
                validator: validateLogin
              ),

              SizedBox(height: 20.0),

              CustomTextFormField(
                controller: _senhaController,
                labelText: 'Senha',
                hintText: 'Senha',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                inputIcon: Icon(Icons.lock, size: 22, color: AppColors.iconPrimaryColor),
                requestFocus: _focusSenha,
                validator: validateSenha
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
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(new Color(0xFFF7F2F8)),
                      )
                  )
              ),
            ],
          )
          )

      )
    );
  }

  void _loginOnPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) {
      return;
    }

    UserModel.of(context).login(_loginController.text, _senhaController.text,
        onSuccess: () {
          Message.onSuccess(
              scaffoldKey: _scaffoldKey,
              message: "Usuário logado com sucesso!",
              onPop: (value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
                  return HomePage();
                }));
              }
          );
          return;
        }, onFail: (String message) {
          Message.onFail(
              scaffoldKey: _scaffoldKey,
              message: message,
              onPop: (value){
                print("Algo de errado com o login!");
              }
          );
          return;
        });
  }
}
