import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:estok_app/entities/user.dart';

class UserRepository{
  static final UserRepository instance = UserRepository._();
  UserRepository._();

  Future<void> saveUsuario(User usuario) async{
    String userString = json.encode(usuario.toJson());
    var instance = await SharedPreferences.getInstance();
    await instance.setString("user.prefs",userString);
    print("[USER REPOSITORY] Usuário salvo com sucesso");
  }

  Future<User> getUsuario() async{
    var instance = await SharedPreferences.getInstance();
    String userString = await instance.getString("user.prefs");
    if(userString.isEmpty){
      return null;
    }

    Map userJson = json.decode(userString);
    User usuario = User.fromJson(userJson);
    return usuario;
  }

  Future<User> deleteUsuario() async{
    var instance = await SharedPreferences.getInstance();
    await instance.setString("user.prefs", '');
  }
}