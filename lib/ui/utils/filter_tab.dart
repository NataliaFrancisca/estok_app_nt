import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/repository/local/stock_repository.dart';

Future<List<Stock>> filterDataTab(String type) async{
  List<Stock> filteredData = [];
  List<Stock> list = await StockRepository.instance.getStock();

  String typeUpperCase = type.toUpperCase();

  if(typeUpperCase == 'TODOS'){
    filteredData.addAll(list);
  }else{
    list.forEach((Stock stock) {
      if(stock.toJson()['status_estoque'] == typeUpperCase){
        filteredData.add(stock);
      }
    });
  }

  return filteredData;
}