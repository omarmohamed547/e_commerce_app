import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/feature/auth/login/cubit/login_states.dart';
import 'package:e_commerce_app/feature/auth/login/cubit/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../core/utils/asset_manager.dart';
import '../../../core/utils/custom_elevated_button.dart';
import '../../../core/utils/custom_text_field.dart';
import '../../../core/utils/dailog_utilis.dart';
import '../../../core/utils/di/di.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = getIt<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginStates>(
      bloc: loginViewModel,
      listener: (context, state) {
        if (state is FailureLoginStates) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Error',
              postActionname: 'Ok',
              context: context,
              message: state.error.errorMessage);
        } else if (state is SucessLoginStates) {
          DailogUtilis.hideLoading(context: context);
          DailogUtilis.showMessage(
              title: 'Success',
              postActionname: 'Ok',
              context: context,
              postActionFunc: () {
                SharedPrefernceUtilis.saveData(
                    'token', state.loginModelEntity.token);
                Navigator.pushReplacementNamed(context, AppRoutes.homeScreenId);
              },
              message: 'Login Successfully');
        } else {
          DailogUtilis.showLoading(context: context, message: "Loading...");
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.primaryColorLight,
          body: SingleChildScrollView(
            child: Form(
              key: loginViewModel.formKey,
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
                      "E-mai address",
                      style: AppStyle.Medium16White,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      controller: loginViewModel.emailController,
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
                      controller: loginViewModel.passwordController,
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
                      height: 10.h,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password",
                          style: AppStyle.Medium16White,
                        )),
                    SizedBox(
                      height: 56.h,
                    ),
                    custom_elevated_button(
                        onButtonClicked: () {
                          loginViewModel.login();
                        },
                        text: "Login"),
                    SizedBox(
                      height: 56.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: AppStyle.Medium16White,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.registerScreenId);
                            },
                            child: Text(
                              "Create Account",
                              style: AppStyle.Medium16White,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
