import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/product_stock_model.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/stock_api.dart';
import 'package:estok_app_natalia_francisca/repository/local/stock_repository.dart';
import 'package:estok_app_natalia_francisca/ui/utils/filter_tab.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockModel extends Model{
  Future<List<Stock>> futureStock;
  Future<List<Stock>> filteredStock;

  static StockModel of (BuildContext context){
    return ScopedModel.of<StockModel>(context);
  }

  setState(){
    notifyListeners();
  }

  Future<void> fetch() async{
    List<Stock> listStock = await StockApi.instance.getAll();

    if(listStock != null){
      StockRepository.instance.saveStock(listStock);
      print("STOCK SALVO COM SUCESSO");
    }
    // this.futureStock = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    // setState();
    // this.futureStock = StockApi.instance.getAll(type);
    // setState();
  }

  void addStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    Stock stockSave = await StockApi.instance.save(stock);

    if(stockSave != null){
      onSuccess();
    }else{
      onFail('Algo deu errado ao tentar salvar o estoque');
    }
  }

  void deleteStock(int id, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    var stockDelete = await StockApi.instance.delete(id);

    if(stockDelete != null){
      onSuccess();
    }else{
      onFail("Algo de eraddo na hora de deletar o estoque");
    }
  }

  void updateStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    Stock stockUpdated = await StockApi.instance.update(stock);

    if(stockUpdated != null){
      onSuccess();
    }else{
      onFail('Algo de errado ao tentar atualizar o estoque');
    }
  }

  void filterStock(String type) async{
    Future<List<Stock>> listStock = filterDataTab(type);
    this.filteredStock = listStock;
    print(this.filteredStock);
  }

}