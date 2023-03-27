import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/product_stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/home_page.dart';
import 'package:estok_app_natalia_francisca/ui/pages/new_product_page.dart';
import 'package:estok_app_natalia_francisca/ui/tile/product.tile.dart';
import 'package:estok_app_natalia_francisca/ui/validator/stock_status_validator.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_stock_details.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockPage extends StatefulWidget {
  final Stock _stock;
  StockPage(this._stock);
  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> with StockStatusValidator {
  String tranformDate(String value) {
    final date = DateTime.parse(value);
    var month = date.month < 10 ? "0${date.month}" : date.month;
    return "${date.day}/$month/${date.year}";
  }

  @override
  void initState(){
    super.initState();
    _reload();
  }

  void _reload(){
    ProductStockModel.of(context).fetch(widget._stock.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget._stock.descricao}',
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return HomePage();
              }));
            },
          ),
          actions: [],
          centerTitle: true,
          backgroundColor: new Color(0xFFF7F2F8),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
              return NewProductPage(widget._stock);
            }))
          },
          tooltip: 'Add New Product',
          child: const Icon(Icons.add)
        ),

        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextStockDetails('TIPO: ${widget._stock.tipo}'),
                        CustomTextStockDetails(
                            'Entrada em: ${tranformDate(widget._stock.data_entrada)}'),
                        CustomTextStockDetails(
                            'Validade: ${tranformDate(widget._stock.data_validade)}'),
                        CustomTextStockDetails(
                            'Valor Total: ${widget._stock.tipo}'),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "${widget._stock.quantidade_total}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              color: AppColors.blackTextColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                            '${status(widget._stock.quantidade_total)['message']}'
                                .toUpperCase(),
                            style: TextStyle(
                                color:
                                    status(widget._stock.quantidade_total)['color'],
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 17),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.black),
                          onPressed: null,
                        ),
                        SizedBox(height: 17),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.black),
                            onPressed: null),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Produtos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          height: 0,
                          thickness: 1,
                          indent: 19,
                          endIndent: 12,
                          color: new Color(0xFFBEBBBB),
                        ),
                      )
                    ]
                ),

                SizedBox(height: 20),

                Expanded(
                  child:ScopedModelDescendant<ProductStockModel>(
                    builder: (context, child, productStockModel){
                      return FutureBuilder(
                        future: productStockModel.futureProduct,
                        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
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
            
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return ProductTile(snapshot.data[index]);
                                      },
                                    ),
                                  );
                              }
                          }
                        }
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        )
      );



        

        // body: ScopedModelDescendant<ProductStockModel>(
        //       builder: (context, child, productStockModel){
        //         return FutureBuilder(
        //           future: productStockModel.futureProduct,
        //           builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
        //             switch(snapshot.connectionState){
        //               case ConnectionState.none:
        //                 return Message.alert("Não foi possivel obter os dados necessários");
        //               case ConnectionState.waiting:
        //                 return Message.loading(context, color: AppColors.primaryColor);
                      
        //               default:
        //                 if(snapshot.hasError){
        //                   return Message.alert("Não foi possível obter os dados do servidor");
        //                 } else if(!snapshot.hasData){
        //                   return Message.alert("Não foi possivel obter os dados dos estoques");
        //                 } else if(snapshot.data.isEmpty){
        //                   return Message.alert("Nenhum estoque encontrado", fontSize: 16);
        //                 } else{
        //                     return RefreshIndicator(
        //                       onRefresh: () async{
        //                         this._reload();
        //                       },
        //                       child: ListView.builder(
        //                         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        //                         itemCount: snapshot.data.length,
        //                         itemBuilder: (BuildContext context, int index){
        //                           return ProductTile(snapshot.data[index]);
        //                         },
        //                       ),
        //                     );
        //                 }
        //             }
        //           }
        //         );
        //       }
        //     ),
          
       
  }
}
