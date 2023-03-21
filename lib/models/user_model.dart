import 'package:estok_app_natalia_francisca/entities/user.dart';
import 'package:estok_app_natalia_francisca/repository/api/user.dart';
import 'package:estok_app_natalia_francisca/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  User user;

  static UserModel of(BuildContext context){
    return ScopedModel.of<UserModel>(context);
  }

  void login(String email, String senha,
   {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    // TODO informar a classe api os meus dados, obter esses dados, obter meu usuario
    user = await UserApi.instance.signIn(email, senha);

    if(user != null){
      await UserRepository.instance.saveUsuario(user);
      onSuccess();
    }else{
      onFail("Erro ao efetuar login para $email");
    }
  }

}