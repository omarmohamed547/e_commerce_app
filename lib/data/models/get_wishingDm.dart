import 'package:e_commerce_app/data/models/Product_response_modelDM.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';

class GetWishingResponseDm extends GetWishingResponseEntity {
  GetWishingResponseDm({super.status, super.count, super.data, this.message});

  String? message;

  factory GetWishingResponseDm.fromJson(Map<String, dynamic> json) {
    return GetWishingResponseDm(
      message: json["message"],
      status: json["status"],
      count: json["count"],
      data: json["data"] == null
          ? []
          : List<DatumProductDm>.from(
              json["data"]!.map((x) => DatumProductDm.fromJson(x))),
    );
  }
}
