import 'dart:convert';

import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/user.dart';
import 'package:estok_app_natalia_francisca/repository/local/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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
      print("RESPONSE[PRODUCT] $data");

      product = (data as List)?.map((json){
        return Product.fromJson(json as Map<String, dynamic>);
      })?.toList();

      return product;
    }on Exception catch(error){
      print("Algo de errado na API Products");
      return null;
    }
  }
}