import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  ProductTile(this._product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: _product.image != null 
                ? NetworkImage('${_product.image}')
                : AssetImage('assets/images/default_product.png'), 
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
            SizedBox(width: 10),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_product.nome}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: new Color(0xFF555353),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${_product.descricao}",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: new Color(0xFF949191)
                              ),
                            )
                          ]),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text(
                            'R\$${_product.valor_item}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'R\$${_product.valor_unitario}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 10),

                SizedBox(
                  width: 250,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_product.quantidade}',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        
                      ),
                      ButtonBar(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black),
                            onPressed: null),
                          IconButton(
                            icon: Icon(Icons.share, color: Colors.black),
                            onPressed: null)
                        ],
                      )
                    ]
                  ),
                ),
              ]
            ),
          ]
        ),

        SizedBox(height: 10),

        Divider(
          height: 0,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: new Color(0xFFBEBBBB),
        ),
        
      ]
    );
  }
}
