import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/models/DeleteOrAddResponseFavouriteDm.dart';
import 'package:e_commerce_app/data/models/get_wishingDm.dart';
import 'package:e_commerce_app/domain/Repository/wishing/wishing_dataSource.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishingDatasource)
class GetWishingdatasoueceImpl implements WishingDatasource {
  final ApiManager apiManager;
  GetWishingdatasoueceImpl({required this.apiManager});
  @override
  Future<Either<Failure, GetWishingResponseDm>> getWishing() async {
    try {
      var token = SharedPrefernceUtilis.getData('token');
      var response = await apiManager.getData(
        apiEndpoints: ApiEndpoints.getWishingendpoint,
        headers: {'token': token},
      );

      var getWishingResponse = GetWishingResponseDm.fromJson(response.data);
      return response.statusCode! >= 200 && response.statusCode! < 300
          ? Right(getWishingResponse)
          : Left(Failure(errorMessage: getWishingResponse.message!));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteOrAddResponseFavouriteDm>> addCartToWishing(
      String productId) async {
    try {
      var token = SharedPrefernceUtilis.getData('token');
      var response = await apiManager.postData(
        apiEndpoints: ApiEndpoints.getWishingendpoint,
        body: {"productId": productId},
        headers: {'token': token},
      );

      var getWishingResponse =
          DeleteOrAddResponseFavouriteDm.fromJson(response.data);
      return response.statusCode! >= 200 && response.statusCode! < 300
          ? Right(getWishingResponse)
          : Left(Failure(errorMessage: getWishingResponse.message!));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteOrAddResponseFavouriteDm>> deleteCartFromWishing(
      String productId) async {
    try {
      var token = SharedPrefernceUtilis.getData('token');
      var response = await apiManager.deleteData(
        apiEndpoints: "${ApiEndpoints.getWishingendpoint}/$productId",
        headers: {'token': token},
      );

      var getWishingResponse =
          DeleteOrAddResponseFavouriteDm.fromJson(response.data);
      return response.statusCode! >= 200 && response.statusCode! < 300
          ? Right(getWishingResponse)
          : Left(Failure(errorMessage: getWishingResponse.message!));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
