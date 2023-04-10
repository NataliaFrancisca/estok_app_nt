import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/models/historic_model.dart';
import 'package:estok_app_natalia_francisca/ui/tile/historic_tile.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoricPage extends StatefulWidget {
  @override
  _HistoricPageState createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "HISTORICO",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),
        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
      ),

      bottomNavigationBar: CustomBottomNavBar('historic_page'),
    
      body: Center(
        child: ScopedModelDescendant<HistoricModel>(builder: (context, child, historicModel) {
            return FutureBuilder(
              future: historicModel.getList(),
              builder: (BuildContext context, AsyncSnapshot<List<Historic>> snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                    return Message.alert("Não foi possivel obter os dados necessários");
                  case ConnectionState.waiting:
                    return Message.loading(context, color: AppColors.primaryColor);
                  default:
                    if(snapshot.hasError){
                      return Message.alert("Não foi possível obter os dados do servidor");
                    } else if(!snapshot.hasData){
                      return Message.alert("Não foi possivel obter os dados de histórico");
                    } else if(snapshot.data.isEmpty){
                      return Message.alert("Nenhum histórico encontrado", fontSize: 16);
                    }else {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HistoricTile(snapshot.data[index]);
                        }
                      );
                    }
                }
              },
            );
          })
      )
    );
  }
}