import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_date.dart';
import 'package:flutter/material.dart';

class CustomDateInputField extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestFocus;
  final FormFieldValidator<String> validator;

  CustomDateInputField({
    @required this.controller,
    @required this.hintText,
    this.firstDate,
    this.lastDate,
    this.focusNode,
    this.requestFocus,
    this.validator,
  });

  @override
  State<CustomDateInputField> createState() => _CustomDateInputFieldState();
}

class _CustomDateInputFieldState extends State<CustomDateInputField> {
 final FocusNode _focusDataTime = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      focusNode: _focusDataTime,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15.0),
          ),

          labelStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat",

          ),

          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
              color: Colors.grey[600],
          ),

          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 18),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          
      ),

      onTap: () async{
        // WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        
          DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101),

            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor,
                  ),
                ),
                child: child,
              );
            },
            
          );

          if(pickedDate != null ){
            print(pickedDate); 
            String formattedDate = tranformDate(pickedDate); 
            print(formattedDate);
            setState(() {
              widget.controller.text = formattedDate;
            });
            FocusManager.instance.primaryFocus.unfocus();
        }else{
            print("Date is not selected");
            FocusManager.instance.primaryFocus.unfocus();
        }
      },

    );
  }
}

