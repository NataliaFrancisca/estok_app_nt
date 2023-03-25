import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductStockModel extends Model{
  Future<List<Product>> futureProduct;
  Future<int> futureTotalProducts;

  static ProductStockModel of (BuildContext context){
    return ScopedModel.of<ProductStockModel>(context);
  }

  setState(){
    notifyListeners();
  }

  Future<void> fetch(int id) async{
    this.futureProduct = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));
    setState();
    this.futureProduct = ProductApi.instance.getAll(id);
    setState();
  }
}


