import 'package:flutter/material.dart';

import 'package:estok_app/colors.dart';
import 'package:estok_app/ui/pages/historic_page.dart';
import 'package:estok_app/ui/pages/home_page.dart';
import 'package:estok_app/ui/pages/perfil_page.dart';

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

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return _pagesOptions[index];
        },

        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
      ),

    (Route route) => false);
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