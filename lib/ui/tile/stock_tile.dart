import 'package:flutter/material.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/ui/pages/stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/validator/stock_status_validator.dart';

class StockTile extends StatelessWidget with StockStatusValidator{
  final Stock _stock;
  final Function _reloadPage;
  StockTile(this._stock, this._reloadPage);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => StockPage(this._stock)));
          if(refresh == 'refresh'){
            this._reloadPage();
        }
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: new Color(0xFFE7EFF2),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 12, left: 22, right: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${this._stock.descricao}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700
                        ),
                    ),

                    SizedBox(height: 13.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Total: ${this._stock.quantidade_total}'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        )
                      ),

                      Text(
                        'TIPO: ${this._stock.tipo}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                          )
                      ),
                      ]
                    )
                  ],
                ),
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: status(this._stock.quantidade_total)['color'],
                    ),

                    SizedBox(height: 15.0),

                    Text(
                      '${status(this._stock.quantidade_total)['message']}'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        color: status(this._stock.quantidade_total)['color'],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}