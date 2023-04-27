import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/user_api.dart';
import 'package:estok_app/repository/local/user_repository.dart';

class UserModel extends Model{
  User user;

  static UserModel of(BuildContext context){
    return ScopedModel.of<UserModel>(context);
  }

  void login(String email, String senha, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    user = await UserApi.instance.signIn(email, senha);

    if(user != null){
      await UserRepository.instance.saveUsuario(user);
      onSuccess();
    }else{
      onFail("Erro ao efetuar login!");
    }
  }

  void logOut({VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    user = await UserApi.instance.signOut();

    if(user != null){
      await UserRepository.instance.deleteUsuario();
      onSuccess();
    }else{
      onFail("Erro ao fazer logout");
    }
  }

}