import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_date.dart';
import 'package:flutter/material.dart';

class HistoricTile extends StatelessWidget {
  final Historic historic;
  HistoricTile(this.historic);

  String nameHistoric(String value){
    if(value == 'ADD'){
      return 'INSERÇÃO ${historic.type} ${historic.name}';
    }else if(value == 'UPDATE'){
      return 'ATUALIZAÇÃO ${historic.type} ${historic.name}';
    }else{
      return 'REMOÇÃO ${historic.type} ${historic.name}';
    }
  }
  
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
                  SizedBox(
                    width: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameHistoric(historic.action).toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF555353)
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(
                          "${historic.type}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: new Color(0xFF949191)
                          )
                        ),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        tranformDate(DateTime.parse(historic.date)),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor
                        )
                      ),

                      Text(
                        tranformDateHour(DateTime.parse(historic.date)),
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