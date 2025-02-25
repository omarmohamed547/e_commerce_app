import 'package:e_commerce_app/domain/entities/product_entity.dart';

class GetCartResponseEntity {
  GetCartResponseEntity({
    required this.status,
    required this.numOfCartItems,
    required this.cartId,
    required this.data,
  });

  final String? status;
  final num? numOfCartItems;
  final String? cartId;
  final GetCartDataEntity? data;
}

class GetCartDataEntity {
  GetCartDataEntity({
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
  final List<GetCartProductElementEntity>? products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final num? totalCartPrice;
}

class GetCartProductElementEntity {
  GetCartProductElementEntity({
    required this.count,
    required this.id,
    required this.product,
    required this.price,
  });

  final num? count;
  final String? id;
  final DatumProductEntity? product;
  final num? price;
}
