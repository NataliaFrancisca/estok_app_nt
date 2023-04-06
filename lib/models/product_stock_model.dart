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
  num priceStock = 0;
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
    getPriceStock();
  }

  void addProduct(Product product, Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    final resultCheckImageFile = await checkImageFile();
    if(resultCheckImageFile == null){
      onFail('Erro ao adicionar a imagem do produto');
      return;
    }else{
      product.imagem = resultCheckImageFile; 
    }

    Product productSaved = await ProductApi.instance.save(product);
    bool shouldUpdateStock;

    if(productSaved != null){
      Stock updatedCountTotalStockProducts = await StockApi.instance.update(functionUpdateCountTotalProducts(stock, product, false));
      shouldUpdateStock = updatedCountTotalStockProducts != null;
    }

    if(productSaved != null && shouldUpdateStock){
      product = productSaved;
      onSuccess();
    }else{
      onFail('Erro ao adicionar o produto');
    }

    setState();
  }

  void updateProduct(
    Product product,
    Stock stock,
    bool changedTheImageProduct,
    bool changedTheProductTotal,
    {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    
    if(changedTheImageProduct){
      final resultCheckImageFile = await checkImageFile();

      if(resultCheckImageFile == null){
        onFail('Erro ao atualizar a imagem do produto');
        return;
      }else{
        product.imagem = resultCheckImageFile; 
      }
    }

    Product productUpdated = await ProductApi.instance.update(product);
    bool stockUpdated = true;

    if(changedTheProductTotal){
      Stock updatedCountStockTotalProducts = await StockApi.instance.update(functionUpdateCountTotalProducts(stock, product, false));
      stockUpdated = updatedCountStockTotalProducts != null;
    }

    if(productUpdated != null && stockUpdated){
      product = productUpdated;
      onSuccess();
    }else{
      onFail('Erro ao atualizar o produto');
    }

    setState();
  }

  Future<String> uploadImageFile(File file) async{
    return await UploadApi.instance.upload(file);
  }

  functionUpdateCountTotalProducts(Stock stock, Product product, bool isDeleteProduct){
    stock.quantidade_total = isDeleteProduct ? stock.quantidade_total - product.quantidade : stock.quantidade_total + product.quantidade;
    stock.data_entrada = removeTheUTC(stock.data_entrada);
    stock.data_validade = removeTheUTC(stock.data_validade);
    return stock;
  }

  checkImageFile() async{
    if(file != null){
      String urlImage = await uploadImageFile(this.file);
      print("OLHA A URL $urlImage");
      if(urlImage != null){
        file = null;
        return urlImage;
      }else{
        return null;
      }
    }
  }
  
  getPriceStock() async{
    List listProducts = await this.futureProduct;
    num sumPrice = 0;

    listProducts.forEach((element) {
      double valorItem = element.toJson()['valor_item'];
      int valorQuantidade = element.toJson()['quantidade'];

      num sum = valorItem * valorQuantidade;
      sumPrice += sum;
    });

    this.priceStock = sumPrice;
    setState();
  }
  
}


