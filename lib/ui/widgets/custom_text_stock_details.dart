import 'package:flutter/material.dart';

class CustomTextStockDetails extends StatelessWidget {
  final String _text;
  CustomTextStockDetails(this._text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Text(
        "${this._text}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        )
      ),
    );
  }
}