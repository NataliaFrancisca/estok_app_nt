import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StockRepository{
  static final StockRepository instance = StockRepository._();
  StockRepository._();

  Future<void> saveStock(List<Stock> stock) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Stock.encode(stock);
    await prefs.setString('stock.prefs', encodedData);
    print("[LOG] $encodedData - STOCK SALVO COM SUCESSO");
  }

  Future<List<Stock>> getStock() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stockString = await prefs.getString('stock.prefs');
    final List<Stock> listStock = Stock.decode(stockString);
    return listStock;
  }
}