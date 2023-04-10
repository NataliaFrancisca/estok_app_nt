import 'package:flutter/material.dart';
import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/product_stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/new_product_page.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_money.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_product_updater.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';

class ProductTile extends StatefulWidget {
  final Product _product;
  final Stock _stock;
  final Function _reloadPage;
  final GlobalKey _scaffoldParentKey;
  ProductTile(this._product, this._stock, this._reloadPage, this._scaffoldParentKey);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  Product previousProduct;

  @override
  void initState(){
    previousProduct = Product.clone(widget._product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: this.widget._product.imagem != null && this.widget._product.imagem.contains('http')
                ? NetworkImage('${widget._product.imagem}')
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
                              '${widget._product.nome}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.greyTextColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            
                            SizedBox(height: 10),
                            Text(
                              "${widget._product.descricao}",
                              style: TextStyle(
                                fontSize: 12,
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
                            '${formatValueTypeMoney(widget._product.valor_item)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            '${formatValueTypeMoney(widget._product.valor_unitario)}',
                            style: TextStyle(
                              fontSize: 16,
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
                        '${widget._product.quantidade}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ButtonBar(
                        children: [
                          IconButton(
                            icon: Icon(Icons.share, color: Colors.black),
                            onPressed: (){
                              showDialog(
                                context: context,
                                child: CustomProductUpdater(
                                  widget._product,
                                  updateProduct
                                )
                              );
                            },
                          ),

                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewProductPage(isEditProduct: true, productEdit: this.widget._product, stock: this.widget._stock)));
                            }
                          ),
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

  void updateProduct(int productQuantity){
    if(productQuantity < 0){
      return;
    }
    
    widget._product.quantidade = productQuantity;

    bool changedTheImageProduct = false;
    bool changedTheProductTotal = true;
    
    ProductStockModel.of(context).updateProduct(
      widget._product,
      previousProduct,
      widget._stock,
      changedTheImageProduct,
      changedTheProductTotal,
      onSuccess: (){
        Message.onSuccess(
          scaffoldKey: widget._scaffoldParentKey,
          message: "Produto atualizado com sucesso",
          seconds: 2,
          onPop: (value){
            widget._reloadPage();
          }
        );
        return;
      },

      onFail: (String message){
        Message.onFail(
          scaffoldKey: widget._scaffoldParentKey,
          message: message
        );
        return;
      }
    );
  }
}
