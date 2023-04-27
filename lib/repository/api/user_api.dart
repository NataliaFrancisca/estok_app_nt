import 'dart:convert';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:http/http.dart' as http;

class UserApi{
  static final UserApi instance = UserApi._();
  UserApi._();

  Future<User> signIn(String email, String senha) async {
    try{
      var encodeString = {
        "email": email,
        "senha": senha
      };

      var encode = json.encode(encodeString);
      String url = "http://54.90.203.92/auth/login";

      var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: encode,
      );

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        var data = responseData['data'];
        User user = User.fromJson(data);
        print("[API] Usuário logado com sucesso!");
        return user;
      }else{
        return null;
      }
    } on Exception catch(error){
      print("[API] Erro ao fazer login!");
      return null;
    }
  }

  Future<User> signOut() async {
    try{
      String url = "http://54.90.203.92/auth/logout";
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
      );

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        User user = User.fromJson(responseData);
        print("[API] Logout realizado com sucesso!");
        return user;
      }else{
        return null;
      }
    } on Exception catch(error){
      print("[API] Erro ao fazer logout!");
      return null;
    }
  }

}