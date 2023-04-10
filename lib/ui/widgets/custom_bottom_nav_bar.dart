import 'package:flutter/material.dart';

import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/pages/historic_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/perfil_page.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String _currentPage;
  CustomBottomNavBar(this._currentPage);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  Map<String, int> pageIndex = {
    'home_page': 0,
    'historic_page': 1,
    'perfil_page': 2
  };

  void _onItemTapped(int index) {
    List _pagesOptions = <Widget>[
      HomePage(isMenuNavigator: true),
      HistoricPage(),
      PerfilPage()
    ];
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
      return _pagesOptions[index];
    }));
  }

  @override
  void initState(){
    this._selectedIndex = pageIndex[widget._currentPage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedLabelStyle: TextStyle(
          color: new Color(0xFF909FAD),
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add),label: 'Historico'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded),label: 'Perfil'),
        ],
        currentIndex: this._selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      );
  }
}