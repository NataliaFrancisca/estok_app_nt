import 'package:flutter/material.dart';
import 'package:estok_app/colors.dart';

class CustomLabelInput extends StatefulWidget {
  final String labelText;
  final Widget inputField;

  CustomLabelInput({
    this.labelText,
    this.inputField
  });

  @override
  _CustomLabelInputState createState() => _CustomLabelInputState();
}

class _CustomLabelInputState extends State<CustomLabelInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.labelText}',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.blackTextColor,
          ),
        ),

        SizedBox(height: 8.0),
        widget.inputField,
        SizedBox(height: 20.0),
      ],
    );
  }
}