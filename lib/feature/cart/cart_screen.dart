import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/feature/cart/cartItem.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_states.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_view_model.dart';
import 'package:e_commerce_app/feature/cart/payment/cubit/payment_states.dart';
import 'package:e_commerce_app/feature/cart/payment/cubit/payment_view_model.dart';
import 'package:e_commerce_app/feature/cart/payment/web_view_payment.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:url_launcher/url_launcher.dart';

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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            onButtonClicked: () async {
                              try {
                                final paymentVM = PaymentViewModel.get(context);
                                final cartVM = CartViewModel.get(context);

                                // Get the total price from cart state
                                final totalPrice = (state as SucessCartState)
                                    .getCartResponseEntity
                                    .data!
                                    .totalCartPrice;

                                // Convert to cents (Paymob expects amount in cents)
                                final amountInCents =
                                    (totalPrice! * 100).toInt();

                                // Show loading
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Processing payment...")),
                                );

                                // Complete all payment steps with dynamic price
                                await paymentVM
                                    .completePaymentFlow(amountInCents);

                                // Validate URL
                                if (paymentVM.finalToken == null ||
                                    !paymentVM.finalToken!
                                        .startsWith("https://")) {
                                  throw Exception(
                                      "Invalid payment URL generated");
                                }

                                // Navigate to WebView
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentWebViewScreen(
                                      url: paymentVM.finalToken!,
                                    ),
                                  ),
                                );

                                // Handle payment result
                                if (result == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Payment successful!")),
                                  );

                                  // Optional: Clear cart after successful payment
                                  cartVM.close();
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Payment failed: ${e.toString()}")),
                                );
                                debugPrint("Payment Error: ${e.toString()}");
                              }
                            },
                            text: "Check Out",
                          ),
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
