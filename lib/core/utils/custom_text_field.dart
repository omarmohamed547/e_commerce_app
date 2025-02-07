import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  void Function(String)? onChanged;
  String hintText;
  Color? borderColor;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  Widget? suffixxIcon;
  EdgeInsets? margin;
  String? label;
  int? maxlines;
  TextEditingController? controller;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  bool? obscureText;
  CustomTextField({
    this.onChanged,
    this.obscureText, // Corrected property name
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.maxlines,
    this.suffixxIcon,
    this.label,
    this.prefixIcon,
    this.hintStyle,
    this.margin,
    required this.hintText,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      /* EdgeInsets.only(
        //right: width * 0.02,
       // left: width * 0.02,
        //top: height * 0.05,
      )*/
      // padding: EdgeInsets.symmetric(  horizontal: width * 0.03, vertical: height * 0.001),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText ?? false, // Corrected here
        controller: controller,
        validator: validator,
        maxLines: (obscureText ?? false) ? 1 : maxlines,

        decoration: InputDecoration(
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(width: 1, color: borderColor ?? Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    BorderSide(width: 1, color: borderColor ?? Colors.red)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixxIcon,
            hintText: hintText,
            hintStyle: hintStyle ?? AppStyle.Medium16grey),
      ),
    );
  }
}
