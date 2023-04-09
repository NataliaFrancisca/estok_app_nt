import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:flutter/material.dart';

class CustomProductUpdater extends StatefulWidget {
  final Product product;
  final Function updateProduct;
  CustomProductUpdater(this.product, this.updateProduct);

  @override
  _CustomProductUpdaterState createState() => _CustomProductUpdaterState();
}

class _CustomProductUpdaterState extends State<CustomProductUpdater> {
  int counter = 0;

  @override
  void initState(){
    counter += widget.product.quantidade;
    super.initState();
  }

  void _increment(){
    setState(() {
      counter++;
    });
  }

  void _decrement(){
    setState(() {
       if(this.counter != 0){
        this.counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          title: Text(
            "${widget.product.nome}",
            textAlign: TextAlign.center,
          ),

          titleTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor
          ),

          contentPadding: EdgeInsets.symmetric(vertical: 50),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: (){
                  this._decrement();
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 30,
                )
              ),

              Text(
                "${this.counter}",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF949191)
                ),
              ),

              FlatButton(
                onPressed: (){
                  this._increment();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                )
              )
            ],
          ),

          actionsPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Color(0xFF555353),
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            FlatButton(
              onPressed: (){
                widget.updateProduct(this.counter);
                Navigator.of(context).pop();
              },
              child: Text(
                'Alterar',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              )
            ),

          ],
        ),
      );
  }
}