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
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("Profile Information", style: AppStyle.bold14Primary),
            SizedBox(height: 10),
            _buildProfileInfo("Name", savedName),
            _buildProfileInfo("Email", savedEmail),
            _buildProfileInfo("Phone", savedPhone),
            _buildProfileInfo("Password", savedPassword),
            SizedBox(height: 20),
            Center(
              child: custom_elevated_button(
                onButtonClicked: () async {
                  await SharedPrefernceUtilis.removeData("token");
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginScreenId, (route) => false);
                },
                text: "Logout",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        "$label: $value",
        style: AppStyle.bold14Primary,
      ),
    );
  }
}
