import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: custom_elevated_button(
            onButtonClicked: () async {
              await SharedPrefernceUtilis.removeData("token");
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.loginScreenId, (route) => false);
            },
            text: "Logout"),
      ),
    );
  }
}
