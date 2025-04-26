import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_view_model.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments! as DatumProductEntity;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: AppColors.primaryColorLight),
        iconTheme: IconThemeData(color: AppColors.primaryColorLight),
        title: Text(
          "Product Details",
          style: AppStyle.Medium20Primary.copyWith(
              fontSize: 16, color: Color(0xff06004f)),
        ),
        actions: [
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
            width: 8.w,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              //height: 300.h,
              //width: 398.w,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(16.r)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: ImageSlideshow(
                      initialPage: 0,
                      width: double.infinity,

                      /// The color to paint the indicator.
                      indicatorColor: AppColors.primaryColorLight,

                      /// The color to paint behind th indicator.
                      indicatorBackgroundColor: Colors.grey,

                      /// Auto scroll interval.
                      /// Do not auto scroll with null or 0.
                      // autoPlayInterval: 3000,

                      /// Loops back to first slide.
                      isLoop: true,

                      /// The widgets to display in the [ImageSlideshow].
                      /// Add the sample image file into the images folder
                      children: arg.images!.map((url) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: CachedNetworkImage(
                            height: 120.h,
                            width: double.infinity,
                            imageUrl: url,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: Colors.grey,
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  /* CachedNetworkImage(
                      height: 120.h,
                      width: double.infinity,
                      imageUrl: arg.imageCover ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),*/

                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        final productId = arg.id ?? "";
                        final viewModel = WishingViewmodel.get(context);

                        setState(() {
                          if (viewModel.isFavorite(productId)) {
                            viewModel.favoriteProductIds.remove(productId);
                            viewModel.deleteFromWishing(arg);
                          } else {
                            viewModel.favoriteProductIds.add(productId);
                            viewModel.addToWishing(arg);
                          }
                        });
                        context
                            .read<ProductTabViewmodel>()
                            .emit(ProductTabUpdatedState());
                      },
                      child:
                          WishingViewmodel.get(context).isFavorite(arg.id ?? "")
                              ? CirculecontainerIcon(
                                  colorBackground: Colors.white,
                                  icon: Image.asset("assets/icons/heart.png"))
                              : CirculecontainerIcon(
                                  colorBackground: Colors.white,
                                  icon: Icon(
                                    Icons.favorite_border_rounded,
                                    color: AppColors.primaryColorLight,
                                    size: 22,
                                  ),
                                ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250.w,
                  child: AutoText(text: arg.title ?? ""),
                ),
                AutoText(text: "EGP ${arg.price}"),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        height: 40.h,
                        width: 105.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                width: 1, color: Colors.grey.withOpacity(0.5))),
                        child: AutoText(
                          text: '${arg.sold ?? ""} Sold',
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(
                      width: 16.w,
                    ),
                    AutoText(
                      text: "${arg.ratingsAverage ?? ""}",
                      fontWeight: FontWeight.w400,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow,
                    ),
                    Text(
                      "(${arg.ratingsQuantity ?? ""})",
                      style: TextStyle(
                        color: Color(0xff06004f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            AutoText(text: "Descreiption"),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 4.h, bottom: 4.h),
              child: ReadMoreText(
                "${arg.description}",
                style: TextStyle(
                    color: Color(0xff06004f).withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: AppColors.primaryColorLight,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorLight),
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorLight),
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    AutoText(text: "Total price"),
                    SizedBox(
                      height: 8.h,
                    ),
                    AutoText(text: "EGP ${arg.price}"),
                  ],
                ),
                SizedBox(
                    width: 240.w,
                    // padding: EdgeInsets.symmetric(horizontal: 0.05.w, vertical: 0.01.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppColors.primaryColorLight),
                              borderRadius: BorderRadius.circular(16)),
                          backgroundColor: AppColors.primaryColorLight,
                          elevation: 0),
                      onPressed: () {
                        ProductTabViewmodel.get(context)
                            .addToCart(arg.id ?? "");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/icons/🦆 icon _shopping cart_.png",
                              color: Colors.white,
                            ),
                            Text(
                              "Add To Cart",
                              style: AppStyle.bold20Primary
                                  .copyWith(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
