import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/dailog_utilis.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_states.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductItem extends StatefulWidget {
  DatumProductEntity productobj;
  ProductItem({
    required this.productobj,
    super.key,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WishingViewmodel.get(context).getWishing();
  }

  @override
  void didUpdateWidget(covariant ProductItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    WishingViewmodel.get(context)
        .getWishing(); // Ensure state updates when widget updates
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishingViewmodel, WishingStates>(
        builder: (context, state) {
      final wishingViewmodel = WishingViewmodel.get(context);

      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 220.w,
            height: 310.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              16)), // Match the container's border radius

                      child: CachedNetworkImage(
                        height: 120.h,
                        width: double.infinity,
                        imageUrl: widget.productobj.imageCover ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: Colors.grey,
                        )),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: BlocBuilder<WishingViewmodel, WishingStates>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              final productId = widget.productobj.id ?? "";
                              final viewModel = WishingViewmodel.get(context);

                              setState(() {
                                if (viewModel.isFavorite(productId)) {
                                  viewModel.favoriteProductIds
                                      .remove(productId); // Instant UI response
                                  viewModel
                                      .deleteFromWishing(widget.productobj);
                                } else {
                                  viewModel.favoriteProductIds.add(productId);
                                  viewModel.addToWishing(widget.productobj);
                                }
                              });
                            },
                            child: wishingViewmodel
                                    .isFavorite(widget.productobj.id ?? "")
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                AutoText(
                  text: widget.productobj.description ?? "No desc",
                ),
                Row(
                  children: [
                    AutoText(text: "${widget.productobj.price ?? ""}"),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "${widget.productobj.price ?? ""}",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Color(0xff004182)),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AutoText(
                          text: "Review",
                          fontWeight: FontWeight.w400,
                        ),
                        AutoText(
                            fontWeight: FontWeight.w400,
                            text:
                                "(${widget.productobj.ratingsAverage ?? ""},)"),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: InkWell(
              onTap: () {
                ProductTabViewmodel.get(context)
                    .addToCart(widget.productobj.id ?? "");
              },
              child: CirculecontainerIcon(
                colorBackground: AppColors.primaryColorLight,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class CirculecontainerIcon extends StatelessWidget {
  Widget icon;
  Color colorBackground;
  CirculecontainerIcon({
    required this.colorBackground,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.w,
      child: CircleAvatar(backgroundColor: colorBackground, child: icon),
    );
  }
}

class AutoText extends StatelessWidget {
  String text;
  FontWeight? fontWeight;
  AutoText({
    this.fontWeight,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, top: 4.h, bottom: 4.h),
      child: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        text,
        style: TextStyle(
            color: Color(0xff06004f),
            fontSize: 14,
            fontWeight: fontWeight ?? FontWeight.bold),
      ),
    );
  }
}
