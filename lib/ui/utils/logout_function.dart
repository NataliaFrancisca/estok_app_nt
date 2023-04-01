import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/login_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';

void logOut(context, GlobalKey scaffolKey){
      UserModel.of(context).logOut(
        onSuccess: (){
          Message.onSuccess(
            scaffoldKey: scaffolKey,
            message: "Logout realizado com sucesso!",
            seconds: 2,
            onPop: (value){
               Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                    return LoginPage();
                  },

                  transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }
                ),

                (Route route) => false);
              }  
          );
        return;
      },

      onFail: (String message){
        Message.onFail(
          scaffoldKey: scaffolKey,
          message: message
        );
        return;
      }
    );
  }