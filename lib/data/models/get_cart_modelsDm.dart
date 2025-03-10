import 'package:e_commerce_app/data/models/Product_response_modelDM.dart';
import 'package:e_commerce_app/data/models/category_or_brand_modelDm.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';

class GetCartResponseDm extends GetCartResponseEntity {
  GetCartResponseDm({
    super.status,
    super.numOfCartItems,
    super.cartId,
    super.data,
    this.message,
  });

  final String? message;
  factory GetCartResponseDm.fromJson(Map<String, dynamic> json) {
    return GetCartResponseDm(
      status: json["status"],
      message: json["message"],
      numOfCartItems: json["numOfCartItems"],
      cartId: json["cartId"],
      data: json["data"] == null ? null : GetCartDataDm.fromJson(json["data"]),
    );
  }
}

class GetCartDataDm extends GetCartDataEntity {
  GetCartDataDm({
    super.id,
    super.cartOwner,
    super.products,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.totalCartPrice,
  });

  factory GetCartDataDm.fromJson(Map<String, dynamic> json) {
    return GetCartDataDm(
      id: json["_id"],
      cartOwner: json["cartOwner"],
      products: json["products"] == null
          ? []
          : List<GetCartProductElementDm>.from(json["products"]!
              .map((x) => GetCartProductElementDm.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      totalCartPrice: json["totalCartPrice"],
    );
  }
}

class GetCartProductElementDm extends GetCartProductElementEntity {
  GetCartProductElementDm({
    super.count,
    super.id,
    super.product,
    super.price,
  });

  factory GetCartProductElementDm.fromJson(Map<String, dynamic> json) {
    return GetCartProductElementDm(
      count: json["count"],
      id: json["_id"],
      product: json["product"] == null
          ? null
          : DatumProductDm.fromJson(json["product"]),
      price: json["price"],
    );
  }
}
