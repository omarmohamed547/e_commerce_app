import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/custom_text_field.dart';
import 'package:e_commerce_app/core/utils/di/di.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTabScreen extends StatefulWidget {
  const ProductTabScreen({super.key});

  @override
  State<ProductTabScreen> createState() => _ProductTabScreenState();
}

class _ProductTabScreenState extends State<ProductTabScreen> {
  ProductTabViewmodel productTabViewmodel = getIt<ProductTabViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productTabViewmodel.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: CustomTextField(
                            prefixIcon: Image.asset(
                                "assets/icons/🦆 icon _search_.png"),
                            hintText: "what do you search for?"),
                      ),
                      Expanded(
                          flex: 2,
                          child: Image.asset(
                              "assets/icons/🦆 icon _shopping cart_.png"))
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 650.h, // Adjust height as needed
                    child: BlocBuilder<ProductTabViewmodel, ProductTabStates>(
                      bloc: productTabViewmodel,
                      builder: (context, state) {
                        if (state is LoadingProductTabState) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.grey));
                        } else if (state is SuccessProductTabState) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        0.75, // Adjust based on your design
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 16.w,
                                    crossAxisCount: 2),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.productDetailsId,
                                      arguments:
                                          state.responseEntity.data![index]);
                                },
                                child: ProductItem(
                                  productobj: state.responseEntity.data![index],
                                ),
                              );
                            },
                          );
                        } else if (state is FailureProductTabState) {
                          return Center(
                              child:
                                  Text("Error: ${state.error.errorMessage}"));
                        }
                        return Container(); // Empty state
                      },
                    ),
                  ),
                ]))));
  }
}
