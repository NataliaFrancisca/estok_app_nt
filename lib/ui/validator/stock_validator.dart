import 'package:estok_app/ui/utils/format_date.dart';

final messageIsEmpty = (String inputLabel) => 'O campo $inputLabel precisa ser preenchido';

class StockValidator{
  String validateDescription(String value){
    if(value.isEmpty){
      return messageIsEmpty('descrição');
    }

    if(value.length < 3){
      return 'O campo deve ter no mínimo 3 caracteres';
    }

    return null;
  }

  String validateEntryDate(String entryDateString, String expirationDateString){
    if(entryDateString.isEmpty){
      return messageIsEmpty('data de entrada');
    }

    if(entryDateString.isNotEmpty && expirationDateString.isNotEmpty){
      DateTime entryDate = tranformStringDate(entryDateString);
      DateTime expirationDate = tranformStringDate(expirationDateString);

      if(entryDate.isAfter(expirationDate)){
        return 'A data de entrada não pode ser depois da data de validade';
      }

      if(entryDate.isAtSameMomentAs(expirationDate)){
        return 'A data de entrada não pode ser no mesmo dia da validade';
      }
    }

    return null;
  }

  String validateExpirationDate(String entryDateString, String expirationDateString){
     if(entryDateString.isEmpty){
      return messageIsEmpty('data de validade');
    }

    if(entryDateString.isNotEmpty && expirationDateString.isNotEmpty){
      DateTime entryDate = tranformStringDate(entryDateString);
      DateTime expirationDate = tranformStringDate(expirationDateString);

      if(entryDate.isAfter(expirationDate)){
        return 'A data de validade não pode ser antes da data de entrada';
      }

      if(entryDate.isAtSameMomentAs(expirationDate)){
        return 'A data de validade não pode ser no mesmo dia da data de entrada';
      }
    }

    return null;
  }
}