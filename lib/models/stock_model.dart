import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/historic_model.dart';
import 'package:estok_app_natalia_francisca/models/product_stock_model.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/stock_api.dart';
import 'package:estok_app_natalia_francisca/repository/local/historic_repository.dart';
import 'package:estok_app_natalia_francisca/repository/local/stock_repository.dart';
import 'package:estok_app_natalia_francisca/ui/utils/filter_tab.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_date.dart';
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

  Future<void> fetch(type) async{
    List<Stock> listStock = await StockApi.instance.getAll();

    if(listStock != null){
      await StockRepository.instance.saveStock(listStock);
      print("STOCK SALVO COM SUCESSO");
    }

    filterStock(type);

    // this.futureStock = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    // setState();
    // this.futureStock = StockApi.instance.getAll();
    // setState();

    // print("GETTING ALL");
  }

  void addStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    Stock stockSave = await StockApi.instance.save(stock);
    
    if(stockSave != null){
      onSuccess();
      saveHistoric(stock.descricao, 'ADD');
    }else{
      onFail('Algo deu errado ao tentar salvar o estoque');
    }
  }

  void deleteStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    deleteAllProductFromStock(stock.id);
    var stockDelete = await StockApi.instance.delete(stock.id);
    List<Product> listProductsDeleted = await ProductApi.instance.getAll(stock.id);

    if(stockDelete != null && listProductsDeleted.isEmpty){
      onSuccess();
      saveHistoric(stock.descricao, 'DELETE');
    }else{
      onFail("Algo de eraddo na hora de deletar o estoque");
    }
  }

  void updateStock(Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    Stock stockUpdated = await StockApi.instance.update(stock);

    if(stockUpdated != null){
      onSuccess();
      saveHistoric(stock.descricao, 'UPDATE');
    }else{
      onFail('Algo de errado ao tentar atualizar o estoque');
    }
  }

  void filterStock(String type) async{
    Future<List<Stock>> listStock = filterDataTab(type);
    this.filteredStock = listStock;
    setState();
  }

  void deleteAllProductFromStock(int stockID) async{
    List<Product> listProducts = await ProductApi.instance.getAll(stockID);
    
    listProducts.forEach((Product product) {
      ProductApi.instance.delete(product);
    });
  }


  void saveHistoric(String nameStock, String action) async{
    Historic historic = Historic(
      name: nameStock,
      date: DateTime.now().toString(),
      type: 'ESTOQUE',
      action: action
    );

    await HistoricRepository.instance.save(historic);
  }


}