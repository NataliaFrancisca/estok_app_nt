import 'package:flutter/material.dart';
import 'package:estok_app/colors.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void onSuccess({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required String message, int seconds, Function onPop }){

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(scaffoldKey.currentContext).accentColor,
      duration: Duration(seconds: seconds ?? 3),
    ));

    if(onPop != null){
      Future.delayed(Duration(seconds: seconds ?? 3)).then((onPop));
    }
  }

  static void onFail({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required String message, int seconds, Function onPop }){

    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[800],
      duration: Duration(seconds: seconds ?? 3),
    ));

    if(onPop != null){
      Future.delayed(Duration(seconds: seconds ?? 3))
          .then((onPop));
    }
  }

  static Widget loading(
    BuildContext context, {
      double width,
      double heigth,
      double strokeWidth,
      @required Color color,
    }){
      return Center(
        child: Container(
          width: width ?? 40.0,
          height: heigth ?? 40.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).accentColor),
              strokeWidth: strokeWidth ?? 5.0,
          ),
        ),  
      );
    }


  static Widget alert(message, {double fontSize, double fontWeight, Color color}){
    return Center(
      child: Text(message,
      style: TextStyle(
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? Colors.grey[600],
      ))
    );
  }

  static void alertDialog(BuildContext context, {
    String title = '',
    String subtitle = '',
    @required String textOkButton,
    @required Function onPressedOkButton,
    String textNoButton = 'Não',
    Function onPressedNoButton,
  }){
    
    showDialog(context: context,
      builder: (context){
        return Container(
          child: AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center
            ),
            titleTextStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(subtitle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            actions: [
              textNoButton == null ? Container() :
              FlatButton(
                child: Text(
                  textNoButton,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor
                  ),
                ),

                onPressed: onPressedNoButton
                
              ),

              FlatButton(
                child: Text(
                  textOkButton,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor
                  ),
                ),

                onPressed: onPressedOkButton
              ),
            ],
          ),
        );
      }
    );
  }
}
