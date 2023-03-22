import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/repository/api/stock_api.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockModel extends Model{
  Future<List<Stock>> futureStock;

  static StockModel of (BuildContext context){
    return ScopedModel.of<StockModel>(context);
  }

  setState(){
    notifyListeners();
  }

  Future<void> fetch(String type) async{
    this.futureStock = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureStock = StockApi.instance.getAll(type);
    setState();
  }

}