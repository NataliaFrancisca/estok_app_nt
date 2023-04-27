import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

import 'package:estok_app/colors.dart';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/product_stock_model.dart';
import 'package:estok_app/ui/pages/stock_page.dart';
import 'package:estok_app/ui/validator/product_validator.dart';
import 'package:estok_app/ui/widgets/custom_label_input.field.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';

class NewProductPage extends StatefulWidget {
  final Stock stock;
  final Product productEdit;
  final bool isEditProduct;

  NewProductPage({
    this.stock,
    this.productEdit,
    this.isEditProduct = false
  });
  
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> with ProductValidator{
  TextEditingController nameProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();
  TextEditingController priceItemProductController = TextEditingController();
  TextEditingController priceUnitProductController = TextEditingController();
  TextEditingController quantityProductController = TextEditingController();
  TextEditingController siteProductController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusName = FocusNode();
  final FocusNode _focusDescription = FocusNode();
  final FocusNode _focusPriceItem = FocusNode();
  final FocusNode _focusPriceUnit = FocusNode();
  final FocusNode _focusQuantity = FocusNode();
  final FocusNode _focusSite = FocusNode();

  var changedTheImageProduct = false;
  var changedTheProductTotal = false;

  Product product = Product();

  @override
  void initState(){
    super.initState();
    updateControllers();
    ProductStockModel.of(context).file = null;
    ProductStockModel.of(context).setState();
  }

  ImageProvider getImage(ProductStockModel productStockModel){
     if(widget.isEditProduct && widget.productEdit.imagem != null){
      if(productStockModel.file != null){
        return FileImage(productStockModel.file);
      }else{
        return NetworkImage(widget.productEdit.imagem);
      }
    }else if(productStockModel.file != null){
      return FileImage(productStockModel.file);
    }else{
      return AssetImage('assets/images/upload_image.png');
    }
  }

  void updateControllers(){
    if(widget.isEditProduct){
      nameProductController.text = widget.productEdit.nome;
      descriptionProductController.text = widget.productEdit.nome;
      priceItemProductController.text = widget.productEdit.valor_item.toString();
      priceUnitProductController.text = widget.productEdit.valor_unitario.toString();
      quantityProductController.text = widget.productEdit.quantidade.toString();
      siteProductController.text = widget.productEdit.site;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.isEditProduct ? "EDITAR PRODUTO" : "NOVO PRODUTO",
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
              return StockPage(widget.stock);
            }));
          },
        ),

        centerTitle: true,
        backgroundColor: AppColors.lightPurpleColor,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  'Clique na imagem para escolher ou tirar uma foto',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    
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
                    focusNode: _focusName,
                    previousFocus: _focusName,
                    nextFocus: _focusDescription,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateName,
                  )
                ),

                
                CustomLabelInput(
                  labelText: 'Descrição',
                  inputField: CustomTextFormField(
                    controller: this.descriptionProductController,
                    hintText: 'Uma das melhores marcas',
                    keyboardType: TextInputType.text,
                    focusNode: _focusDescription,
                    previousFocus: _focusName,
                    nextFocus: _focusPriceItem,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    // maxLines: 4,
                    validator: validateDescription,
                  )
                ),

                CustomLabelInput(
                  labelText: 'Valor Item',
                  inputField: CustomTextFormField(
                    controller: this.priceItemProductController,
                    hintText: 'R\$45.00',
                    keyboardType: TextInputType.number,
                    focusNode: _focusPriceItem,
                    previousFocus: _focusDescription,
                    nextFocus: _focusPriceUnit,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateValueItem,
                  )
                ),

                CustomLabelInput(
                  labelText: 'Valor Unitário',
                  inputField: CustomTextFormField(
                    controller: this.priceUnitProductController,
                    hintText: 'R\$7.00',
                    keyboardType: TextInputType.number,
                    focusNode: _focusPriceUnit,
                    previousFocus: _focusPriceItem,
                    nextFocus: _focusQuantity,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateValueUnit,
                  )
                ),

                CustomLabelInput(
                  labelText: 'Quantidade',
                  inputField: CustomTextFormField(
                    controller: this.quantityProductController,
                    hintText: '10',
                    keyboardType: TextInputType.number,
                    focusNode: _focusQuantity,
                    previousFocus: _focusPriceUnit,
                    nextFocus: _focusSite,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateQuantity,
                  )
                ),

                CustomLabelInput(
                  labelText: 'Site',
                  inputField: CustomTextFormField(
                    controller: this.siteProductController,
                    hintText: 'Informe a URL',
                    keyboardType: TextInputType.text,
                    focusNode: _focusSite,
                    previousFocus: _focusQuantity,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateWebSite,
                  )
                ),

                SizedBox(height: 26.0),

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          widget.isEditProduct ? updateProduct() : registerProduct();
                        },
                        child: Text(
                          widget.isEditProduct ? "EDITAR" : "CADASTRAR",
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
                          backgroundColor: MaterialStateProperty.all(AppColors.lightPurpleColor),
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
                  if(widget.isEditProduct){
                    changedTheImageProduct = true;
                  }
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
                  if(widget.isEditProduct){
                    changedTheImageProduct = true;
                  }
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

  void updateProduct(){
    Product previousProduct = Product.clone(widget.productEdit);

    if(!_formKey.currentState.validate()){
      return;
    }

    if(widget.productEdit.quantidade != int.parse(quantityProductController.text)){
      changedTheProductTotal = true;
    }

    widget.productEdit.nome = this.nameProductController.text;
    widget.productEdit.descricao = this.descriptionProductController.text;
    widget.productEdit.valor_item= double.parse(this.priceItemProductController.text);
    widget.productEdit.valor_unitario = double.parse(this.priceUnitProductController.text);
    widget.productEdit.quantidade = int.parse(this.quantityProductController.text);
    widget.productEdit.site = this.siteProductController.text;

    ProductStockModel.of(context).updateProduct(
      widget.productEdit,
      previousProduct,
      widget.stock,
      changedTheImageProduct,
      changedTheProductTotal,
      onSuccess: (){
        Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Produto atualizado com sucesso",
          seconds: 2,
          onPop: (value){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return StockPage(widget.stock);
          })); 
          }
        );
        return;
      },

      onFail: (String message){
        Message.onFail(
          scaffoldKey: _scaffoldKey,
          message: message
        );
        return;
      }
    );
  }
  
  void registerProduct(){
    if(!_formKey.currentState.validate()){
      return;
    }

    this.product.estoque_id = widget.stock.id;
    this.product.nome = this.nameProductController.text;
    this.product.descricao = this.descriptionProductController.text;
    this.product.valor_item = double.parse(this.priceItemProductController.text);
    this.product.valor_unitario = double.parse(this.priceUnitProductController.text);
    this.product.quantidade = int.parse(this.quantityProductController.text);
    this.product.site = this.siteProductController.text;

    ProductStockModel.of(context).addProduct(
      this.product,
      widget.stock,
      onSuccess: (){
        Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Produto registrado com sucesso",
          seconds: 2,
          onPop: (value){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return StockPage(widget.stock);
          })); 
          }
        );
        return;
      },

      onFail: (String message){
        Message.onFail(
          scaffoldKey: _scaffoldKey,
          message: message
        );
        return;
      }
    );
  }
}