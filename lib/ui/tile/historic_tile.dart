import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:flutter/material.dart';

class HistoricTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'INSERÇÃO PRODUTO OMO',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        'PRODUTO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: new Color(0xFF949191)
                        )
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '09/10/2022',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor
                        )
                      ),

                      Text(
                        '08:20',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),

                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          SizedBox(height: 20),

          Divider(
            height: 0,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: new Color(0xFFBEBBBB),
          ),
        ]
      ),
    );
  }
}