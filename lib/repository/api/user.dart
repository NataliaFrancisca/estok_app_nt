import 'dart:convert';
import 'package:estok_app_natalia_francisca/entities/user.dart';
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
      print("LOG[UserApi.singIng] - $encode");

      var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: encode,
      );

      print(response.statusCode);

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        print("LOG[UserApi.singIng] - $responseData");
        User user = User.fromJson(responseData);
        print("LOG[UserApi.singIng] - $user");
        return user;
      }else{
        return null;
      }
    } on Exception catch(error){
      print("LOG[UserApi.singIng] - $error");
      return null;
    }
  }

}