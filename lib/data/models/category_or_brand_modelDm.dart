import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';

class CategoryOrBrandResponseDm extends CategoryOrBrandRespnseEntity {
  CategoryOrBrandResponseDm(
      {super.results,
      super.metadata,
      super.data,
      this.message,
      this.statusMsg});

  final String? statusMsg;
  final String? message;

  factory CategoryOrBrandResponseDm.fromJson(Map<String, dynamic> json) {
    return CategoryOrBrandResponseDm(
      statusMsg: json["statusMsg"],
      message: json["message"],
      results: json["results"],
      metadata:
          json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum extends DatumEntity {
  Datum({
    super.id,
    super.name,
    super.slug,
    super.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Metadata extends MetadataEntity {
  Metadata({
    super.currentPage,
    super.numberOfPages,
    super.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      currentPage: json["currentPage"],
      numberOfPages: json["numberOfPages"],
      limit: json["limit"],
    );
  }
}
