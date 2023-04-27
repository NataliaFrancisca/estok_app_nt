import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:estok_app/colors.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/tile/stock_tile.dart';
import 'package:estok_app/ui/widgets/message.dart';

class EmAvisoTab extends StatefulWidget {
  @override
  State<EmAvisoTab> createState() => _EmAvisoTabState();
}

class _EmAvisoTabState extends State<EmAvisoTab> {
  Future<List<Stock>> futureList;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    this.futureList = StockModel.of(context).fetch('em aviso');
  }
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StockModel>(builder: (context, child, stockModel){
      return FutureBuilder(
        future: this.futureList,
        builder: (BuildContext context, AsyncSnapshot<List<Stock>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Message.alert("Não foi possivel obter os dados necessários");
            case ConnectionState.waiting:
              return Message.loading(context, color: AppColors.primaryColor);
            default:
              if(snapshot.hasError){
                return Message.alert("Não foi possível obter os dados do servidor");
              } else if(!snapshot.hasData){
                return Message.alert("Não foi possivel obter os dados dos estoques");
              } else if(snapshot.data.isEmpty){
                return Message.alert("Nenhum estoque encontrado", fontSize: 16);
              } else{
                  return RefreshIndicator(
                    onRefresh: () async{
                      this._reload();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return StockTile(snapshot.data[index], _reload);
                      },
                    ),
                  );
              }
          }
        }
      );
    });
  }
}