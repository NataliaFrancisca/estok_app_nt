import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/repository/local/historic_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoricModel extends Model{
  List<Historic> historic;

  static HistoricModel of (BuildContext context){
    return ScopedModel.of<HistoricModel>(context);
  }

  setState(){
    notifyListeners();
  }

  Future<List<Historic>> getList() async{
    List<Historic> list = await HistoricRepository.instance.list();
    return list;
  }
}