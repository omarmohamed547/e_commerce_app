import 'package:e_commerce_app/data/models/category_or_brand_modelDm.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';

class ProductResponseModelDm extends ProductResponseEntity {
  ProductResponseModelDm(
      {super.results,
      super.metadata,
      super.data,
      this.message,
      this.statusMsg});

  String? statusMsg;
  String? message;

  factory ProductResponseModelDm.fromJson(Map<String, dynamic> json) {
    return ProductResponseModelDm(
      message: json["message"],
      statusMsg: json["statusMsg"],
      results: json["results"],
      metadata: json["metadata"] == null
          ? null
          : MetadataProductDm.fromJson(json["metadata"]),
      data: json["data"] == null
          ? []
          : List<DatumProductDm>.from(
              json["data"]!.map((x) => DatumProductDm.fromJson(x))),
    );
  }
}

class DatumProductDm extends DatumProductEntity {
  DatumProductDm({
    super.sold,
    super.images,
    super.subcategory,
    super.ratingsQuantity,
    super.id,
    super.title,
    super.slug,
    super.description,
    super.quantity,
    super.price,
    super.imageCover,
    super.category,
    super.brand,
    super.ratingsAverage,
    super.createdAt,
    super.updatedAt,
    super.datumId,
    super.priceAfterDiscount,
    super.availableColors,
  });

  factory DatumProductDm.fromJson(Map<String, dynamic> json) {
    return DatumProductDm(
      sold: json["sold"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      subcategory: json["subcategory"] == null
          ? []
          : List<CategoryOrBrandResponseDm>.from(json["subcategory"]!
              .map((x) => CategoryOrBrandResponseDm.fromJson(x))),
      ratingsQuantity: json["ratingsQuantity"],
      id: json["_id"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      quantity: json["quantity"],
      price: json["price"],
      imageCover: json["imageCover"],
      category: json["category"] == null
          ? null
          : CategoryOrBrandResponseDm.fromJson(json["category"]),
      brand: json["brand"] == null
          ? null
          : CategoryOrBrandResponseDm.fromJson(json["brand"]),
      ratingsAverage: json["ratingsAverage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      datumId: json["id"],
      priceAfterDiscount: json["priceAfterDiscount"],
      availableColors: json["availableColors"] == null
          ? []
          : List<dynamic>.from(json["availableColors"]!.map((x) => x)),
    );
  }
}

class MetadataProductDm extends MetadataProductEntity {
  MetadataProductDm({
    super.currentPage,
    super.numberOfPages,
    super.limit,
    super.nextPage,
  });

  factory MetadataProductDm.fromJson(Map<String, dynamic> json) {
    return MetadataProductDm(
      currentPage: json["currentPage"],
      numberOfPages: json["numberOfPages"],
      limit: json["limit"],
      nextPage: json["nextPage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "numberOfPages": numberOfPages,
        "limit": limit,
        "nextPage": nextPage,
      };
}
