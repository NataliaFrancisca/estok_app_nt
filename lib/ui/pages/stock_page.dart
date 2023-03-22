import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/ui/validator/stock_status_validator.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_stock_details.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  Stock _stock;
  StockPage(this._stock);
  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> with StockStatusValidator{
  


  String tranformDate(String value){
    final date = DateTime.parse(value);
    var month = date.month < 10 ? "0${date.month}" : date.month;
    return "${date.day}/$month/${date.year}";
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
            fontSize: 15
          ),
        ),

        leading: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
        ),

        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
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
                  CustomTextStockDetails('Entrada em: ${tranformDate(widget._stock.data_entrada)}'),
                  CustomTextStockDetails('Validade: ${tranformDate(widget._stock.data_validade)}'),
                  CustomTextStockDetails('Valor Total: ${widget._stock.tipo}'),
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
                      color: AppColors.blackTextColor
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    '${status(widget._stock.quantidade_total)['message']}'.toUpperCase(),
                      style: TextStyle(
                        color: status(widget._stock.quantidade_total)['color'],
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    )
                  ),

                  SizedBox(height: 17),

                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: null,

                  ),

                  SizedBox(height: 17),

                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: null
                  ),
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

        
      

        ],
      )
    );
  }
}