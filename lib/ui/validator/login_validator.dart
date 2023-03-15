class LoginValidator{
  String validateLogin(String value){
    if(value.isEmpty){
      return "Campo vazio, digite seu e-mail";
    }

    if(!value.contains('@')){
      return "O campo apresenta erros, digite seu e-mail corretamente";
    }

    return null;
  }

  String validateSenha(String value){
    if(value.isEmpty){
      return "Campo vazio, digite sua senha";
    }
    if(value.length < 8){
      return "O campo deve ter no minimo 8 caracteres";
    }

    return null;
  }
}