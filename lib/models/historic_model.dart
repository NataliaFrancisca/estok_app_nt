import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:estok_app/entities/historic.dart';
import 'package:estok_app/repository/local/historic_repository.dart';

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
    list.sort((a,b) => b.date.compareTo(a.date));
    return list;
  }

  void checkHistoricLength() async{
    int length = await HistoricRepository.instance.length();
    if(length == 100){
      await HistoricRepository.instance.delete();
    }
  }
}