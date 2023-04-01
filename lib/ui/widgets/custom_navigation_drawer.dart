import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/models/user_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/login_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomNavigationDrawer extends StatelessWidget {

  final _homeScaffoldKey;
  CustomNavigationDrawer(this._homeScaffoldKey);

  final TextStyle customNavigationTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.primaryColor
  );

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
                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/0/04/Convenience_store_interior.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(0.60), BlendMode.colorBurn)
                      ),
                    ),
      
                    accountName: Text(
                      userModel.user.nome,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    accountEmail: Text(
                      userModel.user.email,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
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
                      style: this.customNavigationTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: (){
                  },
                ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: ListTile(
                  leading: Icon(Icons.store),
                  title: Text(
                    'Estoques',
                    style: this.customNavigationTextStyle,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              child: ListTile(
                  leading: Icon(Icons.playlist_add),
                  title: Text(
                    'Histórico',
                    style: this.customNavigationTextStyle,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: (){
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
              child: ElevatedButton(
                onPressed: (){
                  logOut(context);
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

  void logOut(context){
      UserModel.of(context).logOut(
        onSuccess: (){
          Message.onSuccess(
            scaffoldKey: _homeScaffoldKey,
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
          scaffoldKey: _homeScaffoldKey,
          message: message
        );
        return;
      }
    );
  }
}