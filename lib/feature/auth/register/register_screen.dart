import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/asset_manager.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColorLight,
        body: SingleChildScrollView(
          child: Form(
            // key: registerViewModel.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 85.h,
                  ),
                  Image.asset(height: 71.h, AssetManager.imageAuth),
                  SizedBox(
                    height: 46.9.h,
                  ),
                  Text(
                    "Full Name",
                    style: AppStyle.Medium16White,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    // controller: registerViewModel.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this filled is required";
                      } else {
                        return null;
                      }
                    },
                    hintText: 'enter your full name',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "Mobile Number",
                    style: AppStyle.Medium16White,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    // controller: registerViewModel.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this filled is required";
                      } else {
                        return null;
                      }
                    },
                    hintText: 'enter your Mobile no',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "E-mai address",
                    style: AppStyle.Medium16White,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    // controller: registerViewModel.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this filled is required";
                      } else {
                        return null;
                      }
                    },
                    hintText: 'enter your email adress',
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    "password",
                    style: AppStyle.Medium16White,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    suffixxIcon: Icon(Icons.visibility_off_outlined),
                    // controller: registerViewModel.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this filled is required";
                      } else {
                        return null;
                      }
                    },
                    hintText: 'enter your password',
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                  custom_elevated_button(
                      onButtonClicked: () {}, text: "Sign up")
                ],
              ),
            ),
          ),
        ));
  }
}
