import 'package:e_commerce_app/domain/entities/product_entity.dart';

class GetWishingResponseEntity {
  GetWishingResponseEntity({
    required this.status,
    required this.count,
    required this.data,
  });

  final String? status;
  final num? count;
  final List<DatumProductEntity>? data;
}
