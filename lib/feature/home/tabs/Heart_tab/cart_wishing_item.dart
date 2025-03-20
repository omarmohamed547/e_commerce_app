import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_style.dart';
import 'package:e_commerce_app/core/utils/dailog_utilis.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_view_model.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_viewModel.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartWishingItem extends StatefulWidget {
  DatumProductEntity productItem;

  CartWishingItem({
    required this.productItem,
    super.key,
  });

  @override
  State<CartWishingItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartWishingItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 200.h,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: 90.w,
                  height: 110.h,
                  fit: BoxFit.cover,
                  imageUrl: widget.productItem.imageCover ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              color: Colors.grey,
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.productItem.title}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text("Orange | Size: 40",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "EGP" + "${widget.productItem.price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Container(
                      height: 36.h,
                      width: 122.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: AppColors.primaryColorLight),
                      child: Center(
                        child: Text(
                          "Add To Cart",
                          style: AppStyle.Medium16White.copyWith(fontSize: 14),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: InkWell(
            onTap: () {
              WishingViewmodel.get(context)
                  .deleteFromWishing(widget.productItem);
            },
            child: CirculecontainerIcon(
                colorBackground: Colors.white,
                icon: Image.asset("assets/icons/heart.png")),
          ),
        ),
      ],
    );
  }
}
