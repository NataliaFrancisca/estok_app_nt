import 'dart:io';

import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/stock_api.dart';
import 'package:estok_app_natalia_francisca/repository/api/upload_api.dart';
import 'package:estok_app_natalia_francisca/repository/local/historic_repository.dart';
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
      onFail('Erro ao adicionar a imagem do produto, verifique um tamanho diferente de imagem ou tente novamente');
      return;
    }else{
      product.imagem = resultCheckImageFile; 
    }

    Product productSaved = await ProductApi.instance.save(product);
    bool shouldUpdateStock;

    if(productSaved != null){
      Stock updatedCountTotalStockProducts = await StockApi.instance.update(functionUpdateTotalProduct(stock, product, null, 'ADD'));
      shouldUpdateStock = updatedCountTotalStockProducts != null;
    }

    if(productSaved != null && shouldUpdateStock){
      onSuccess();
      saveHistoric(product.nome, 'ADD');
    }else{
      onFail('Erro ao adicionar o produto');
    }

    setState();
  }

  void updateProduct(
    Product product,
    Product previousProduct,
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
      Stock updatedCountStockTotalProducts = await StockApi.instance.update(functionUpdateTotalProduct(stock, product, previousProduct, 'UPDATE'));
      stockUpdated = updatedCountStockTotalProducts != null;
    }

    if(productUpdated != null && stockUpdated){
      onSuccess();
      saveHistoric(product.descricao, 'UPDATE');
    }else{
      onFail('Erro ao atualizar o produto');
    }

    setState();
  }

  void deleteProduct(Product product, Stock stock, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async{
    var productDelete = await ProductApi.instance.delete(product);
    var updatedCountStockTotalProducts = await StockApi.instance.update(functionUpdateTotalProduct(stock, product, null, 'DELETE'));

    if(productDelete != null && updatedCountStockTotalProducts != null){
      onSuccess();
      saveHistoric(product.nome, 'DELETE');
    }else{
      onFail('Erro ao deletar o produto');
    }
  }

  Future<String> uploadImageFile(File file) async{
    return await UploadApi.instance.upload(file);
  }

  functionUpdateTotalProduct(Stock stock, Product product, Product previousProduct, String type){
    switch(type){
      case 'DELETE':
        stock.quantidade_total = stock.quantidade_total - product.quantidade;
        break;
      case 'ADD':
        stock.quantidade_total = stock.quantidade_total + product.quantidade;
        break;
      case 'UPDATE':
        stock.quantidade_total = (stock.quantidade_total - previousProduct.quantidade) + product.quantidade;
        break;
    }
    stock.data_entrada = removeTheUTC(stock.data_entrada);
    stock.data_validade = removeTheUTC(stock.data_validade);

    return stock;
  }

  checkImageFile() async{
    if(file != null){
      String urlImage = await uploadImageFile(this.file);
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

  void saveHistoric(String nameProduct, String action) async{
    Historic historic = Historic(
      name: nameProduct,
      date: DateTime.now().toString(),
      type: 'PRODUTO',
      action: action
    );

    await HistoricRepository.instance.save(historic);
  }
  
}


