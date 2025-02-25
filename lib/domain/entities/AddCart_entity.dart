class AddProductCartResponseEntity {
  AddProductCartResponseEntity({
    required this.status,
    required this.message,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });

  final String? status;
  final String? message;
  final num? numOfCartItems;
  final String? cartId;
  final AddCartDataEntity? data;
}

class AddCartDataEntity {
  AddCartDataEntity({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalCartPrice,
  });

  final String? id;
  final String? cartOwner;
  final List<AddCartProductEntity>? products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final num? totalCartPrice;
}

class AddCartProductEntity {
  AddCartProductEntity({
    required this.count,
    required this.id,
    required this.product,
    required this.price,
  });

  final num? count;
  final String? id;
  final String? product;
  final num? price;
}
