import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/perfil_page.dart';
import 'package:estok_app_natalia_francisca/ui/utils/logout_function.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoricPage extends StatefulWidget {
  @override
  _HistoricPageState createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
   int _selectedIndex = 1;

  static List _widgetOptions = <Widget>[
    HomePage(),
    HistoricPage(),
    PerfilPage(),
  ];

  @override
  void _onItemTapped(int index) {
    setState(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
        return _widgetOptions[index];
      }));
    });
  }

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
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(
          color: new Color(0xFF909FAD),
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add),label: 'Historico'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded),label: 'Perfil'),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),

      body: Center(
        child: 
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, UserModel userModel){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                    children: [
                      Text("HISTORICO")
                    
                    ],
        
                ),
              );
            }
          )
      )
      
    );
  }
}