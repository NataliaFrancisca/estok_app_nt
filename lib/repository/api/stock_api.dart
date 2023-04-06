import 'dart:convert';

import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/entities/user.dart';
import 'package:estok_app_natalia_francisca/repository/api/product_api.dart';
import 'package:estok_app_natalia_francisca/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockApi{
  static final StockApi instance = StockApi._();
  StockApi._();

  BuildContext context;

  Future<List<Stock>> getAll() async{
    List<Stock> stock;

    try{
      String url = "http://54.90.203.92/estoques";
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
      var data = responseData["data"];

      stock = (data as List)?.map((json){
        return Stock.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return stock;
    } on Exception catch(error){
      print('Algo de errado na API');
      return null;
    }
  }

  Future<Stock> save(Stock stock) async{
    try{
      var encode = json.encode(stock.toJsonRequest());
      String url = 'http://54.90.203.92/estoques/';
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

       print("LOG[UserApi.singIng] - ${user.token}");

      var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        },
        body: encode
      );

      print("STATUS ENCODE $encode");
      print("STATUS CODE ${response.statusCode}");

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        Stock stock = Stock.fromJson(responseData);
        print("LOG[STOCKAPI] - stock salvo");
        return stock;
      }else{
        return null;
      }
    }on Exception catch(error){
      return null;
    }
  }

   Future<Map<String, dynamic>>delete(int id) async{
    try{
      String url = 'http://54.90.203.92/estoques/$id';
      User user = await UserRepository.instance.getUsuario();
      String authorization = 'Bearer ${user.token}';

      var response = await http.delete(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': authorization
        }
      );

      if(response.statusCode == 200){
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        return responseData;
      }else{
        return null;
      }
    } on Exception catch(error){
      return null;
    }
  }

  Future<Stock> update(Stock stock) async{
    try{
      var encode = json.encode(stock.toJsonUpdate());
      String url = 'http://54.90.203.92/estoques/';
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
        Stock stock = Stock.fromJson(responseData);
        print("LOG[STOCKAPI] - stock atualizado");
        return stock;
      }else{
        return null;
      }
    }on Exception catch(error){
      return null;
    }
  }
}