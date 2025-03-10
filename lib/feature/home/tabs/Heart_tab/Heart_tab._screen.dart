import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

class HeartTab extends StatelessWidget {
  const HeartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 32.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: CustomTextField(
                      prefixIcon:
                          Image.asset("assets/icons/🦆 icon _search_.png"),
                      hintText: "what do you search for?"),
                ),
                SizedBox(width: 10.w), // Add spacing

                badges.Badge(
                  onTap: () {},
                  badgeContent:
                      BlocBuilder<ProductTabViewmodel, ProductTabStates>(
                    builder: (context, state) {
                      return Text(ProductTabViewmodel.get(context)
                          .numOfCartItems
                          .toString());
                    },
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.cartId);
                    },
                    child:
                        Image.asset("assets/icons/🦆 icon _shopping cart_.png"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
