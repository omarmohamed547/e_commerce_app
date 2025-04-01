import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/domain/entities/login_mode.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';
import 'package:e_commerce_app/feature/auth/register/cubit/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({
    super.key,
  });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String savedName = "";
  String savedEmail = "";
  String savedPhone = "";
  String savedPassword = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    setState(() {
      savedName =
          SharedPrefernceUtilis.getData("name") as String? ?? "Not Available";
      savedEmail =
          SharedPrefernceUtilis.getData("email") as String? ?? "Not Available";
      savedPhone =
          SharedPrefernceUtilis.getData("phone") as String? ?? "Not Available";
      savedPassword = SharedPrefernceUtilis.getData("password") as String? ??
          "Not Available";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Welcome,$savedName", style: AppStyle.bold20Black),
                Text(savedEmail, style: AppStyle.Medium16grey),
                SizedBox(height: 20),
                Text("Your Full Name", style: AppStyle.Medium16Black),
                _buildProfileInfo(savedName),
                Text("Your E-mail", style: AppStyle.Medium16Black),
                _buildProfileInfo(savedEmail),
                Text("Your Password", style: AppStyle.Medium16Black),
                _buildProfileInfo(savedPassword),
                Text("Your mobile number", style: AppStyle.Medium16Black),
                _buildProfileInfo(savedPhone),
                SizedBox(height: 20),
                Center(
                  child: custom_elevated_button(
                    backgroundColor: AppColors.primaryColorLight,
                    onButtonClicked: () async {
                      await SharedPrefernceUtilis.removeData("token");
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.loginScreenId, (route) => false);
                    },
                    text: "Logout",
                    textStyle: AppStyle.bold16White,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String value) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1.5, color: Colors.grey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            value,
            style: AppStyle.Medium16grey,
          ),
        ),
      ),
    );
  }
}
