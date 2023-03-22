import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/ui/validator/stock_status_validator.dart';
import 'package:flutter/material.dart';

class StockTile extends StatelessWidget with StockStatusValidator{
  final Stock _stock;
  StockTile(this._stock);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700
                      ),
                  ),

                  SizedBox(height: 13.0),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Total: 200'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400
                      )
                    ),

                    Text(
                      'TIPO: ${this._stock.tipo}'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
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
                    color: status(200)['color'],
                  ),

                  SizedBox(height: 15.0),

                  Text(
                    '${status(200)['message']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      fontFamily: 'Montserrat',
                      color: status(200)['color'],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}