import '../../colors.dart';
import 'package:estok_app_natalia_francisca/ui/validator/login_validator.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginValidator{
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final FocusNode _focusSenha = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(height: 20.0),

              Text(
                "ESTOK APP",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 34,
                  color: AppColors.blackTextColor,
                ),
              ),

              SizedBox(height: 23.0),

              Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Montserrat',
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

              SizedBox(height: 20.0),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          print("validou os campos");
                        }else{
                          print("alguma coisa está errado");
                        }
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
}
