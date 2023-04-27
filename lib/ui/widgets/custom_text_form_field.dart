import 'package:flutter/material.dart';
import 'package:estok_app/colors.dart';

final borderStyle = (Color borderColor) => OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: borderColor),
  borderRadius: BorderRadius.circular(15.0),
);

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final inputIcon;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode requestFocus;
  final FormFieldValidator<String> validator;
  final FloatingLabelBehavior behaviorLabel;
  final EdgeInsets inputPadding;
  final int maxLines;
  final FocusNode previousFocus;
  final FocusNode nextFocus;

  CustomTextFormField({
    @required this.controller,
    @required this.hintText,
    this.labelText,
    this.inputIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.requestFocus,
    this.validator,
    this.behaviorLabel = FloatingLabelBehavior.auto,
    this.inputPadding = const EdgeInsets.only(bottom: 20.0),
    this.maxLines = 1,
    this.previousFocus,
    this.nextFocus
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  final customTextFormField = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ? _obscureText : false,
      focusNode: widget.focusNode,
      validator: widget.validator,
      controller: widget.controller,
      maxLines: widget.maxLines,
      key: customTextFormField,

      onFieldSubmitted: (term){
        _fieldFocusChange(context, widget.previousFocus, widget.nextFocus);
      },

      decoration: InputDecoration(
        enabledBorder: borderStyle(AppColors.primaryColor),
        focusedBorder: borderStyle(AppColors.primaryColor),

        errorBorder: borderStyle(Colors.red),
        focusedErrorBorder: borderStyle(Colors.red),

        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),

        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: Colors.grey[600]
        ),

        alignLabelWithHint: true,
        contentPadding: widget.inputPadding,
        prefixIcon: widget.inputIcon,
        floatingLabelBehavior: widget.behaviorLabel,

        suffixIcon: widget.obscureText ? new GestureDetector(
          onTap:(){
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ) : null
      ),

    );
  }

    _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);  
    }
}

