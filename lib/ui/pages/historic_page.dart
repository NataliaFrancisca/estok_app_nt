import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/perfil_page.dart';
import 'package:estok_app_natalia_francisca/ui/tile/historic_tile.dart';
import 'package:estok_app_natalia_francisca/ui/utils/logout_function.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoricPage extends StatefulWidget {
  @override
  _HistoricPageState createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "HISTORICO",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),
        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
      ),

      bottomNavigationBar: CustomBottomNavBar('historic_page'),
    
      body: Center(
        child: 
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, UserModel userModel){
              return Center(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    HistoricTile(),
                    HistoricTile(),
                  ],
                )
              );
            }
          )
      )
      
    );
  }
}