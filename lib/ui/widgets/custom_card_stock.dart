import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/validator/stock_status_validator.dart';
import 'package:flutter/material.dart';

class CustomCardStock extends StatelessWidget with StockStatusValidator{
  String stockCardTitle;
  int totalStock;
  String typeGrid;

  CustomCardStock({
    @required this.stockCardTitle,
    @required this.totalStock,
    @required this.typeGrid,
  });

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
                      '${this.stockCardTitle}'.toUpperCase(),
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
                      'Total: ${this.totalStock}'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      )
                    ),

                    Text(
                      'TIPO: ${this.typeGrid}'.toUpperCase(),
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
                    color: status(this.totalStock)['color'],
                  ),

                  SizedBox(height: 15.0),

                  Text(
                    '${status(this.totalStock)['message']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      color: status(this.totalStock)['color'],
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
