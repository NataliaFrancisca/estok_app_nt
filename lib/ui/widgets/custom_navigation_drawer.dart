import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:estok_app/colors.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/ui/pages/historic_page.dart';
import 'package:estok_app/ui/pages/home_page.dart';
import 'package:estok_app/ui/pages/perfil_page.dart';
import 'package:estok_app/ui/utils/logout_function.dart';

final TextStyle customNavigationTextStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: AppColors.primaryColor
);

class CustomNavigationDrawer extends StatelessWidget {
  final _homeScaffoldKey;
  CustomNavigationDrawer(this._homeScaffoldKey);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            ScopedModelDescendant(
              builder: (BuildContext context, Widget child, UserModel userModel){
                return SizedBox(
                  height: 200,
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/default_user.png'),
                      backgroundColor: Colors.transparent,
                    ),

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/box_decoration_default.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.60), BlendMode.colorBurn)
                      ),
                    ),
      
                    accountName: Text(
                      userModel.user.nome,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    accountEmail: Text(
                      userModel.user.email,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }
            ),

            SizedBox(height: 14.0),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: ListTile(
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text(
                      'Meu Perfil',
                      style: customNavigationTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
                        return PerfilPage();
                      }));
                    },
                ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: ListTile(
                  leading: Icon(Icons.store),
                  title: Text(
                    'Estoques',
                    style: customNavigationTextStyle,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
                      return HomePage(isMenuNavigator: true);
                    }));
                  },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: ListTile(
                  leading: Icon(Icons.playlist_add),
                  title: Text(
                    'Histórico',
                    style: customNavigationTextStyle,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
                      return HistoricPage();
                    }));
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
              child: ElevatedButton(
                onPressed: (){
                  logOut(context, _homeScaffoldKey);
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
                  padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                  backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                )
            ),
          )
          ],
        )
      )
    );
  }
}