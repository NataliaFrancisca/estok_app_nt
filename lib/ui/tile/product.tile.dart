import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/images/back_account.png'),
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
                              "UM PRODUTO",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: new Color(0xFF555353),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Uma das melhores marcas em uma casa só",
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
                          Text('R\$25,00'),
                          Text('R\$25,00'),
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
										Text('10'),
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
