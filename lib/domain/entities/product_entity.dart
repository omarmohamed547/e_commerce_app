import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';

class ProductResponseEntity {
  ProductResponseEntity({
    required this.results,
    required this.metadata,
    required this.data,
  });

  final num? results;
  final MetadataProductEntity? metadata;
  final List<DatumProductEntity>? data;
}

class DatumProductEntity {
  DatumProductEntity({
    required this.sold,
    required this.images,
    required this.subcategory,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
    required this.createdAt,
    required this.updatedAt,
    required this.datumId,
    required this.priceAfterDiscount,
    required this.availableColors,
  });

  final num? sold;
  final List<String>? images;
  final List<CategoryOrBrandRespnseEntity>? subcategory;
  final num? ratingsQuantity;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final num? quantity;
  final num? price;
  final String? imageCover;
  final CategoryOrBrandRespnseEntity? category;
  final CategoryOrBrandRespnseEntity? brand;
  final num? ratingsAverage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? datumId;
  final num? priceAfterDiscount;
  final List<dynamic>? availableColors;
}

class MetadataProductEntity {
  MetadataProductEntity({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
    required this.nextPage,
  });

  final num? currentPage;
  final num? numberOfPages;
  final num? limit;
  final num? nextPage;
}
