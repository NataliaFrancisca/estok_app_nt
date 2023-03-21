class LoginValidator{
  String validateLogin(String value){
    if(value.isEmpty){
      return "Campo vazio, digite seu e-mail";
    }

    if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
      return "Digite um e-mail valido!";
    }

    return null;
  }

  String validateSenha(String value){
    if(value.isEmpty){
      return "Campo vazio, digite sua senha";
    }
    if(value.length < 8){
      return "O campo deve ter no mínimo 8 caracteres";
    }

    return null;
  }
}