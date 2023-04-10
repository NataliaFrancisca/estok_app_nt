import 'package:flutter/material.dart';
import 'package:estok_app_natalia_francisca/colors.dart';
import 'package:estok_app_natalia_francisca/ui/utils/format_date.dart';

final customBorderStyle = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(15.0),
);

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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      validator: widget.validator,
      focusNode: widget.focusNode,
      readOnly: true,

      decoration: InputDecoration(
        enabledBorder: customBorderStyle,
        errorMaxLines: 4,
        focusedBorder: customBorderStyle,
        errorBorder: customBorderStyle,

        labelStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
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
        FocusScope.of(context).requestFocus(new FocusNode());
          DateTime pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), 
            firstDate: DateTime(2012), 
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

          if(pickedDate != null){
            setState(() {
              widget.controller.text = tranformDate(pickedDate); 
            });
          }else{
            FocusManager.instance.primaryFocus.unfocus();
          }
      },

    );
  }
}

