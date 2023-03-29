import 'dart:io';

import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/product.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/product_stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_label_input.field.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class NewProductPage extends StatefulWidget {
  final Stock _stock;
  NewProductPage(this._stock);
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  TextEditingController nameProductController = TextEditingController();

  ImageProvider getImage(ProductStockModel productStockModel){
    if(productStockModel.file == null){
      return AssetImage('assets/images/upload_image.png');
    }else{
      return FileImage(productStockModel.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOVO PRODUTO',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
              return StockPage(widget._stock);
            }));
          },
        ),

        actions: [],
        centerTitle: true,
        backgroundColor: new Color(0xFFF7F2F8),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: null,
          child: Container(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                SizedBox(height: 30.0),

                ScopedModelDescendant<ProductStockModel>(builder: (context, child, productStockModel){
                  return SizedBox(
                    child: InkWell(
                      onTap: (){
                        _onTapImageSheet(productStockModel, context);
                      },
                      child: Container(
                        width: 200,
                        height: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: getImage(productStockModel),
                            fit: BoxFit.fitHeight,
                          )
                        ),
                      )
                    )
                  );
                }),

                SizedBox(height: 11.0),

                Text(
                  'Clique na imagem para tirar uma foto',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Montserrat'
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15.0),

                Divider(),

                SizedBox(height: 15.0),

                CustomLabelInput(
                  labelText: 'Nome',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: 'Heineken Original',
                    keyboardType: TextInputType.text,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                
                CustomLabelInput(
                  labelText: 'Descrição',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: 'Uma das melhores marcas em uma casa só',
                    keyboardType: TextInputType.text,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    maxLines: 4,
                  )
                ),

                CustomLabelInput(
                  labelText: 'Valor Item',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: 'R\$45.00',
                    keyboardType: TextInputType.number,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                CustomLabelInput(
                  labelText: 'Valor Unitário',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: 'R\$7.00',
                    keyboardType: TextInputType.number,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                CustomLabelInput(
                  labelText: 'Quantidade',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: '10',
                    keyboardType: TextInputType.number,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                CustomLabelInput(
                  labelText: 'Site',
                  inputField: CustomTextFormField(
                    controller: this.nameProductController,
                    hintText: 'Informe a URL',
                    keyboardType: TextInputType.text,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                SizedBox(height: 26.0),

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                        //  registerStock();
                        },
                        child: Text(
                            'CADASTRAR'.toUpperCase(),
                          style: TextStyle(fontSize: 15,
                          color: AppColors.blackTextColor)
                        ),

                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                          backgroundColor: MaterialStateProperty.all(new Color(0xFFF7F2F8)),
                        )
                    )
                ),


              ]
            ),
          )
        )
      ),


    );
  }

  void _onTapImageSheet(ProductStockModel productModel, BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton(
              onPressed: () async{
                var picker = ImagePicker();
                var pickedFile = await picker.getImage(source: ImageSource.camera);
              
                if(pickedFile != null){
                  productModel.file = File(pickedFile.path);
                }else{
                  productModel.file = null;
                }

                productModel.setState();
                Navigator.of(context).pop();
              }, 
              child: Text('Camera')
            ),

            FlatButton(
               onPressed: () async{
                var picker = ImagePicker();
                var pickedFile = await picker.getImage(source: ImageSource.gallery);
              
                if(pickedFile != null){
                  productModel.file = File(pickedFile.path);
                }else{
                  productModel.file = null;
                }

                productModel.setState();
                Navigator.of(context).pop();
              }, 
              child: Text('Galeria')
            ),
          ],
        );
      }
    );
  }
}