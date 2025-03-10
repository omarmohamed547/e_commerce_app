import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custom_elevated_button extends StatelessWidget {
  String text;
  Function onButtonClicked;
  Color? backgroundColor;
  TextStyle? textStyle;
  custom_elevated_button({
    this.textStyle,
    this.backgroundColor,
    required this.onButtonClicked,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.symmetric(horizontal: 0.05.w, vertical: 0.01.h),
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: AppColors.primaryColorLight),
              borderRadius: BorderRadius.circular(16)),
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: 0),
      onPressed: () {
        onButtonClicked();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          text,
          style: textStyle ?? AppStyle.bold20Primary,
        ),
      ),
    ));
  }
}
