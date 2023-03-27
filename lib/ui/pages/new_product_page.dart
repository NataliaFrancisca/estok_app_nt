import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/ui/pages/stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_label_input.field.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  final Stock _stock;
  NewProductPage(this._stock);
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  TextEditingController nameProductController = TextEditingController();
  
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.0),

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
}