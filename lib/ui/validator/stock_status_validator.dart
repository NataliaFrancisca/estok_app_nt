import 'package:estok_app_natalia_francisca/colors.dart';

class StockStatusValidator{
  Map status(int stock){
    if(stock >= 1 && stock <= 5){
      return {
        "message": "em aviso",
        "color": AppColors.yellowStatusColor
      };
    }

    if(stock > 5){
      return {
        "message": "em estoque",
        "color": AppColors.greenStatusColor
      };
    }

    return {
      "message": "em falta",
      "color": AppColors.redStatusColor
    };
  }
}
