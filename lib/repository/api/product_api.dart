import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/user.dart';
import 'package:estok_app_natalia_francisca/repository/local/user_repository.dart';

class ProductApi{
  static final ProductApi instance  = ProductApi._();
  ProductApi._();

  BuildContext context;

  Future<List<Product>> getAll(int idStock) async{
    List<Product> product;

    try{
      String url = "http://54.90.203.92/estoques/$idStock/produtos/";
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      var response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
      );

      if(response.statusCode != 200){
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));
      var data = responseData['data'];

      product = (data as List)?.map((json){
        return Product.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return product;
    }on Exception catch(error){
      print("Algo de errado na API Products");
      return null;
    }
  }

  Future<Product> save(Product product) async{
    try{
      var encode = json.encode(product.toJsonRequest());
      String url = "http://54.90.203.92/estoques/${product.estoque_id}/produtos/";
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';
       var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
        body: encode
      );

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Product product = Product.fromJson(responseData);
        print("[API] Produto salvo com sucesso!");
        return product;
      }else{
        print("[API] Erro ao salvar produto!");
        return null;
      }

    } on Exception catch(error){
      return null;
    }
  }

  Future<Map<String, dynamic>> delete(Product product) async{
    try{
      String url = "http://54.90.203.92/estoques/${product.estoque_id}/produtos/${product.id}";
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      var response = await http.delete(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
      );

      if(response.statusCode != 200){
        return null;
      }

      var responseData = json.decode(utf8.decode(response.bodyBytes));
      print("[API] Produto deletado com sucesso!");
      return responseData;
    }on Exception catch(error){
      print("[API] Erro ao deletar o produto!");
      return null;
    }
  }

  Future<Product> update(Product product) async{
    try{
      var encode = json.encode(product.toJson());
      String url = "http://54.90.203.92/estoques/${product.estoque_id}/produtos/";
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      var response = await http.put(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
        body: encode
      );

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Product product = Product.fromJson(responseData);
        print("[API] Produto atualizado com sucesso!");
        return product;
      }else{
        return null;
      }

    } on Exception catch(error){
      print("[API] Erro ao atualizar o produto!");
      return null;
    }
  }

}