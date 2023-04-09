final messageIsEmpty = (String inputLabel) => 'O campo $inputLabel precisa ser preenchido';
final messageLength = (int inputLenght) => 'O campo deve ter no mínimo $inputLenght caracteres';
final messageValueZero = () => 'O campo deve ter valores maiores que R\$0';

class ProductValidator{
  String validateName(String value){
    if(value.isEmpty){
      return messageIsEmpty('nome');
    }

    if(value.length < 3){
      return messageLength(3);
    }
  }

  String validateDescription(String value){
    if(value.isEmpty){
      return messageIsEmpty('descrição');
    }

    if(value.length < 8){
      return messageLength(8);
    }
  }

  String validateValueItem(String value){
    if(value.isEmpty){
      return messageIsEmpty('valor item');
    }

    if(double.parse(value) <= 0){
      return messageValueZero();
    }
  }

  String validateValueUnit(String value){
    if(value.isEmpty){
      return messageIsEmpty('valor unitário');
    }

    if(double.parse(value) <= 0){
      return messageValueZero();
    }
  }

  String validateQuantity(String value){
    if(value.isEmpty){
      return messageIsEmpty('quantidade');
    }

    if(int.parse(value) <= 0){
      return 'O campo deve ter valores maiores que 0';
    }
  }

  String validateSite(String value){
    if(value.isEmpty){
      return messageIsEmpty('site');
    }

    if(!RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+').hasMatch(value)){
      return 'Digite uma URL valída';
    }
  }
}