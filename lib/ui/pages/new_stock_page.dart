import 'package:flutter/material.dart';

import 'package:estok_app/colors.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/utils/format_date.dart';
import 'package:estok_app/ui/validator/stock_validator.dart';
import 'package:estok_app/ui/widgets/custom_date_input_field.dart';
import 'package:estok_app/ui/widgets/custom_label_input.field.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';

class NewStockPage extends StatefulWidget {
  final Stock stockEdit;
  final bool isEditStock;

  NewStockPage({
    this.stockEdit,
    this.isEditStock = false
  });

  @override
  State<NewStockPage> createState() => _NewStockPageState();
}

class _NewStockPageState extends State<NewStockPage> with StockValidator{
  TextEditingController descriptionController = TextEditingController();
  TextEditingController entryDateController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();

  String selectedValue = "GRADE";

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusDescription = FocusNode();
  final FocusNode _focusEntryDate = FocusNode();
  final FocusNode _focusValidateDate = FocusNode();
  final FocusNode _focusType = FocusNode();

  var stock = Stock();

  @override
  void initState(){
    super.initState();
    if(widget.isEditStock){
      descriptionController.text = widget.stockEdit.descricao;
      entryDateController.text = tranformDate(DateTime.parse(widget.stockEdit.data_entrada));
      expirationDateController.text = tranformDate(DateTime.parse(widget.stockEdit.data_validade));
      selectedValue = widget.stockEdit.tipo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.isEditStock ? "EDITAR ESTOQUE" : "NOVO ESTOQUE",
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
              widget.isEditStock ? Navigator.pop(context) : Navigator.pop(context, 'refresh');
            },       
          ),
          actions: [],
          centerTitle: true,
          backgroundColor: AppColors.lightPurpleColor,
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
                    focusNode: _focusDescription,
                    requestFocus: _focusEntryDate,
                    nextFocus: _focusEntryDate,
                    behaviorLabel: FloatingLabelBehavior.never,
                    inputPadding: EdgeInsets.only(left: 25, top: 18, bottom: 18),
                    validator: validateDescription,
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
                                hintText: '12/12/2012',
                                focusNode: _focusEntryDate,
                                validator: (value){
                                  return validateEntryDate(value, this.expirationDateController.text);
                                },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 13.5),
                          child: CustomLabelInput(
                            labelText: "Data de Validade",
                            inputField: CustomDateInputField(
                                controller: this.expirationDateController,
                                hintText: '12/12/2012',
                                focusNode: _focusValidateDate,
                                validator: (value){
                                  return validateExpirationDate(this.entryDateController.text, value);
                                },
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

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),

                        focusNode: _focusType,

                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),

                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        value: selectedValue,
                        items: [
                          DropdownMenuItem(child: Center(child: Text("PACOTE")), value: "PACOTE"),
                          DropdownMenuItem(child: Center(child: Text("GRADE")) ,value: "GRADE"),
                          DropdownMenuItem(child: Center(child: Text("CAIXA")), value: "CAIXA"),
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
                         widget.isEditStock ? updateStock() : registerStock();
                        },
                        child: Text(
                            widget.isEditStock ? "EDITAR" : "CADASTRAR",
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
    this.stock.data_entrada = tranformStringDate(this.entryDateController.text).toString();
    this.stock.data_validade = tranformStringDate(this.expirationDateController.text).toString();
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
            Navigator.pop(context, 'refresh');
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

  void updateStock(){

    if (!_formKey.currentState.validate()) {
      return;
    }

    widget.stockEdit.descricao = this.descriptionController.text;
    widget.stockEdit.data_entrada = tranformStringDate(this.entryDateController.text).toString();
    widget.stockEdit.data_validade = tranformStringDate(this.expirationDateController.text).toString();
    widget.stockEdit.tipo = this.selectedValue;

    StockModel.of(context).updateStock(
      widget.stockEdit,
      onSuccess: (){
        Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: 'Estoque atualizado com sucesso',
          seconds: 2,
          onPop: (value){
            Navigator.pop(context, 'refresh');
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