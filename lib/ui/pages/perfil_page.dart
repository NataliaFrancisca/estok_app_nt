import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/utils/logout_function.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PerfilPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "MEU PERFIL",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),
        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
      ),

      bottomNavigationBar: CustomBottomNavBar('perfil_page'),
      drawer: CustomNavigationDrawer(_scaffoldKey),

      body: Center(
        child: 
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, UserModel userModel){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),

                      Image.asset(
                        'assets/images/default_user.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(
                        height: 50,
                      ),

                      Text(
                        userModel.user.nome.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppColors.primaryColor
                        ),
                      ),

                      Text(
                        userModel.user.email,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: new Color(0xFF555353)
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Divider(
                        height: 0,
                        thickness: 1,
                        color: new Color(0xFFEDEDED),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),

                          SizedBox(
                            width: 20
                          ),

                          Text(
                            userModel.user.telefone,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            )
                          )
                        ],
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),

                          SizedBox(
                            width: 20
                          ),

                          Text(
                            userModel.user.email,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
        
                            )
                          )
                        ],
                      ),

                      SizedBox(
                        height: 70,
                      ),

                      ElevatedButton(
                        onPressed: (){
                          logOut(context, _scaffoldKey);
                        },
                        child: Text(
                            'Sair',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.aWhiteTextColor
                          )
                        ),

                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40, vertical: 18)),
                          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                        )
                    )
                    
                    ],
        
                ),
              );
            }
          )
      )
      
    );
  }
}