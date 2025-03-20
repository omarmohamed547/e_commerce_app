import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cart_wishing_item.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_states.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

class HeartTab extends StatefulWidget {
  const HeartTab({super.key});

  @override
  State<HeartTab> createState() => _HeartTabState();
}

class _HeartTabState extends State<HeartTab> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WishingViewmodel.get(context).getWishing();
  }

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
            BlocBuilder<WishingViewmodel, WishingStates>(
              bloc: WishingViewmodel.get(context)..getWishing(),
              builder: (context, state) {
                if (state is FailureWishingState) {
                  return Text(state.error.errorMessage);
                } else if (state is SuccessWishingState ||
                    state is SucessDeltedWishingState ||
                    state is SucessAddingWishingState) {
                  var wishingList = WishingViewmodel.get(context).wishingList;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: wishingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CartWishingItem(
                            productItem: wishingList[index],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
