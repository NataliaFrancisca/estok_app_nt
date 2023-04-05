import 'dart:io';

import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/stock_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/upload_api.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductStockModel extends Model{
  Future<List<Product>> futureProduct;
  Future<int> futureTotalProducts;
  File file;

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

  void addProduct(Product product, Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    
    if(file != null){
      String urlImage = await uploadImageFile(this.file);
  
      if(urlImage != null){
        product.imagem = urlImage;
        file = null;
      }else{
        onFail('Erro ao adicionar a imagem do produto');
        return;
      }
    }

    Product productSaved = await ProductApi.instance.save(product);
    Stock updatedStock = await StockApi.instance.update(updateStockElements(stock, product));

    if(productSaved != null && updatedStock != null){
      product = productSaved;
      onSuccess();
    }else{
      onFail('Erro ao adicionar o produto');
    }

    setState();
  }

  Future<String> uploadImageFile(File file) async{
    return await UploadApi.instance.upload(file);
  }

  Stock updateStockElements(Stock stock, Product product){
    stock.quantidade_total = stock.quantidade_total + product.quantidade;
    stock.data_entrada = removeTheUTC(stock.data_entrada);
    stock.data_validade = removeTheUTC(stock.data_validade);
    return stock;
  }

}


