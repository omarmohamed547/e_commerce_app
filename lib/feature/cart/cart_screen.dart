import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/feature/cart/cartItem.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_states.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_view_model.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  CartViewModel cartViewModel = getIt<CartViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColorLight),
        title: Text(
          "Cart",
          style: AppStyle.Medium20Primary,
        ),
        centerTitle: true,
        actions: [
          Image.asset("assets/icons/🦆 icon _search_.png"),
          SizedBox(
            width: 24.w,
          ),
          badges.Badge(
            onTap: () {},
            badgeContent: BlocBuilder<ProductTabViewmodel, ProductTabStates>(
              builder: (context, state) {
                return Text(
                    "${ProductTabViewmodel.get(context).numOfCartItems}");
              },
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.cartId);
              },
              child: Image.asset("assets/icons/🦆 icon _shopping cart_.png"),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => cartViewModel,
        child: BlocBuilder<CartViewModel, CartStates>(
          bloc: cartViewModel..getItems(),
          builder: (context, state) {
            if (state is FailureCartState) {
              return Center(
                  child: Text(
                state.error.errorMessage,
                style: AppStyle.bold14Primary,
              ));
            } else if (state is SucessCartState) {
              return Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            state.getCartResponseEntity.data!.products!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: CartItem(
                              productItem: state
                                  .getCartResponseEntity.data!.products![index],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Text(
                                "Total Price",
                                style: AppStyle.bold14Primary,
                              ),
                              Text(
                                "${state.getCartResponseEntity.data!.totalCartPrice}",
                                style: AppStyle.bold14Primary,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: custom_elevated_button(
                              backgroundColor: AppColors.primaryColorLight,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              onButtonClicked: () {},
                              text: "Check Out"),
                        )
                      ],
                    )
                  ],
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
      ),
    );
  }
}
