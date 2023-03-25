import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  ProductTile(this._product);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: _product.image != null 
                ? NetworkImage('${_product.image}')
                : AssetImage('assets/images/back_account.png'), 
                fit: BoxFit.contain,
                width: 85,
                height: 74,
              ),
              SizedBox(width: 10),
              Column(children: [
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_product.nome}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: new Color(0xFF555353),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${_product.descricao}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ]),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Text('R\$${_product.valor_item}'),
                          Text('R\$${_product.valor_unitario}'),
                        ],
                      ),
                    )
                  ],
                ),

								SizedBox(height: 20),

                SizedBox(
									width: 250,
                  child: Row(
									crossAxisAlignment: CrossAxisAlignment.center,
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										Text('${_product.quantidade}'),
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
                  ]),
                )
              ]),
            ]));
  }
}
