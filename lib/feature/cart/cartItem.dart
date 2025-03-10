import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/dailog_utilis.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatefulWidget {
  GetCartProductElementEntity productItem;

  CartItem({
    required this.productItem,
    super.key,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              imageUrl: widget.productItem.product!.imageCover ?? "",
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
                    '${widget.productItem.product!.title}',
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
              IconButton(
                onPressed: () {
                  DailogUtilis.showMessage(
                    context: context,
                    message: "Are yoy want to delete this item",
                    postActionname: "ok",
                    postActionFunc: () {
                      CartViewModel.get(context)
                          .deleteItems(widget.productItem.product?.id ?? "");
                    },
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
              Container(
                height: 45.h,
                width: 122.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.primaryColorLight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1.5)),
                      height: 30.h,
                      width: 30.w,
                      child: CircleAvatar(
                          backgroundColor: AppColors.primaryColorLight,
                          child: InkWell(
                            onTap: () {
                              int count = widget.productItem.count!.toInt();
                              count--;
                              CartViewModel.get(context).update(
                                  widget.productItem.product?.id ?? "", count);
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                    Text(
                      widget.productItem.count.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1.5)),
                      height: 30.h,
                      width: 30.w,
                      child: CircleAvatar(
                          backgroundColor: AppColors.primaryColorLight,
                          child: InkWell(
                            onTap: () {
                              int count = widget.productItem.count!.toInt();
                              count++;
                              CartViewModel.get(context).update(
                                  widget.productItem.product?.id ?? "", count);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
