import 'package:e_commerce_app/domain/entities/AddCart_entity.dart';

class AddProductCartResponseDm extends AddProductCartResponseEntity {
  AddProductCartResponseDm(
      {super.status,
      super.message,
      super.numOfCartItems,
      super.cartId,
      super.data,
      this.statusMsg});

  final String? statusMsg;

  factory AddProductCartResponseDm.fromJson(Map<String, dynamic> json) {
    return AddProductCartResponseDm(
      status: json["status"],
      statusMsg: json["statusMsg"],
      message: json["message"],
      numOfCartItems: json["numOfCartItems"],
      cartId: json["cartId"],
      data: json["data"] == null ? null : AddCartDataDm.fromJson(json["data"]),
    );
  }
}

class AddCartDataDm extends AddCartDataEntity {
  AddCartDataDm({
    super.id,
    super.cartOwner,
    super.products,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.totalCartPrice,
  });

  factory AddCartDataDm.fromJson(Map<String, dynamic> json) {
    return AddCartDataDm(
      id: json["_id"],
      cartOwner: json["cartOwner"],
      products: json["products"] == null
          ? []
          : List<AddCartProductDM>.from(
              json["products"]!.map((x) => AddCartProductDM.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      totalCartPrice: json["totalCartPrice"],
    );
  }
}

class AddCartProductDM extends AddCartProductEntity {
  AddCartProductDM({
    super.count,
    super.id,
    super.product,
    super.price,
  });

  factory AddCartProductDM.fromJson(Map<String, dynamic> json) {
    return AddCartProductDM(
      count: json["count"],
      id: json["_id"],
      product: json["product"],
      price: json["price"],
    );
  }
}
