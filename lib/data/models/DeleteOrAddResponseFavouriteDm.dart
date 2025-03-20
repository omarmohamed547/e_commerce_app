import 'package:e_commerce_app/domain/entities/DeleteOrAddFavRespone_entity.dart';

class DeleteOrAddResponseFavouriteDm extends DelteOrAddResponseFavouriteEntity {
  DeleteOrAddResponseFavouriteDm(
      {super.status, super.message, super.data, this.statusMsg});

  final String? statusMsg;

  factory DeleteOrAddResponseFavouriteDm.fromJson(Map<String, dynamic> json) {
    return DeleteOrAddResponseFavouriteDm(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<String>.from(json["data"]!.map((x) => x)),
    );
  }
}
