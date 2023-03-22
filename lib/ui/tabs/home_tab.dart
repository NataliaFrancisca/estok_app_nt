import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_card_stock.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatefulWidget {
  final String type;
  HomeTab(this.type);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  void initState(){
    super.initState();
    _reload();
  }

  void _reload(){
    StockModel.of(context).fetch(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StockModel>(builder: (context, child, stockModel){
      return FutureBuilder(
        future: stockModel.futureStock,
        builder: (BuildContext context, AsyncSnapshot<List<Stock>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Message.alert("Não foi possivel obter os dados necessários");
            case ConnectionState.waiting:
              return Message.loading(context, color: Colors.red);
            
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
                        return CustomCardStock(snapshot.data[index]);
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