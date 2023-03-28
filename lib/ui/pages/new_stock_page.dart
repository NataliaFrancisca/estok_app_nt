import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/entities/stock.dart';
import 'package:estok_app_natalia_francisca/models/stock_model.dart';
import 'package:estok_app_natalia_francisca/ui/pages/stock_page.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_date_input_field.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_label_input.field.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app_natalia_francisca/ui/widgets/message.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class NewStockPage extends StatefulWidget {
  @override
  State<NewStockPage> createState() => _NewStockPageState();
}

class _NewStockPageState extends State<NewStockPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController entryDateController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  String selectedValue = "Grade";

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var stock = Stock();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "NOVO ESTOQUE",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15
          ),
        ),

        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return HomePage();
            } ));  
            },       
          ),
          actions: [],
          centerTitle: true,
          backgroundColor: new Color(0xFFF7F2F8),
      ),

      body: SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.0),

                CustomLabelInput(
                  labelText: 'Descrição',
                  inputField: CustomTextFormField(
                    controller: this.descriptionController,
                    labelText: 'Descrição',
                    hintText: 'Descrição do produto',
                    keyboardType: TextInputType.text,
                    requestFocus: null,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                  )
                ),

                Table(
                  children: [
                    TableRow(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(right: 13.5),
                          child: CustomLabelInput(
                            labelText: "Data de Entrada",
                            inputField: CustomDateInputField(
                                controller: this.entryDateController,
                                hintText: '12/12/2012'
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 13.5),
                          child: CustomLabelInput(
                            labelText: "Data de Validade",
                            inputField: CustomDateInputField(
                                controller: this.expirationDateController,
                                hintText: '12/12/2012'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ),

                CustomLabelInput(
                  labelText: "Tipo",
                  inputField: Container(
                    width: double.infinity,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),

                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        value: selectedValue,
                        items: [
                          DropdownMenuItem(child: Center(child: Text("Pacote")), value: "Pacote"),
                          DropdownMenuItem(child: Center(child: Text("Grade")) ,value: "Grade"),
                          DropdownMenuItem(child: Center(child: Text("Caixa")), value: "Caixa"),
                        ],
                        onChanged: (String newValue){
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                    ),
                  )
                ),

                SizedBox(height: 50.0),

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                         registerStock();
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
            )
          )
        ),
      )
    );
  }

  void registerStock(){

    if (!_formKey.currentState.validate()) {
      return;
    }
    
    this.stock.descricao = this.descriptionController.text;
    this.stock.data_entrada = this.entryDateController.text;
    this.stock.data_validade = this.expirationDateController.text;
    this.stock.tipo = this.selectedValue;
    this.stock.quantidade_total = 0;

    StockModel.of(context).addStock(
      this.stock,
      onSuccess: (){
        Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: 'Estoque salvo com sucesso',
          seconds: 2,
          onPop: (value){
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context){
              return HomePage();
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
