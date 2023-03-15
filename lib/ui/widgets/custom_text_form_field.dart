import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  String labelText;
  String hintText;
  TextInputType keyboardType;
  Icon inputIcon;
  bool obscureText;
  TextEditingController controller;
  FocusNode focusNode;
  FocusNode requestFocus;

  CustomTextFormField({
    @required this.controller,
    @required this.labelText,
    @required this.hintText,
    @required this.inputIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.requestFocus,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ? _obscureText : false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15.0),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat"
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
              color: Colors.grey[600]
          ),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(bottom: 15.0),
          prefixIcon: widget.inputIcon,
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
}

