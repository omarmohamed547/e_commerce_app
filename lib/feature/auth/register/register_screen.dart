import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/asset_manager.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:e_commerce_app/core/utils/dailog_utilis.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/feature/auth/register/cubit/register_states.dart';
import 'package:e_commerce_app/feature/auth/register/cubit/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel registerViewModel = getIt<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel, RegisterStates>(
      bloc: registerViewModel,
      listener: (context, state) {
        if (state is FailureRegisterStates) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Error',
              postActionname: 'Ok',
              context: context,
              message: state.error.errorMessage);
        } else if (state is SucessRegisterStates) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Success',
              postActionname: 'Ok',
              context: context,
              message: 'Register Successfully');
        } else {
          DailogUtilis.showLoading(context: context, message: "Loading...");
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColorLight,
          body: SingleChildScrollView(
            child: Form(
              key: registerViewModel.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      controller: registerViewModel.nameController,
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
                      controller: registerViewModel.phoneController,
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
                      controller: registerViewModel.emailController,
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
                      controller: registerViewModel.passwordController,
                      suffixxIcon: Icon(Icons.visibility_off_outlined),
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
                      height: 32.h,
                    ),
                    Text(
                      "repassword",
                      style: AppStyle.Medium16White,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      controller: registerViewModel.repaswordController,
                      suffixxIcon: Icon(Icons.visibility_off_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "this filled is required";
                        } else {
                          return null;
                        }
                      },
                      hintText: 'enter your repassword',
                    ),
                    SizedBox(
                      height: 56.h,
                    ),
                    custom_elevated_button(
                        onButtonClicked: () {
                          registerViewModel.register();
                        },
                        text: "Sign up")
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
