import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/models/get_cart_modelsDm.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_dataSource.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCartDatasource)
class GetCartDatasourceImpl implements GetCartDatasource {
  ApiManager apiManager;
  GetCartDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, GetCartResponseDm>> getCart() async {
    try {
      var token = SharedPrefernceUtilis.getData('token');
      var response = await apiManager.getData(
          apiEndpoints: ApiEndpoints.addCartendpoint,
          headers: {'token': token});
      var getCartResponse = GetCartResponseDm.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(getCartResponse);
      } else {
        return Left(Failure(errorMessage: getCartResponse.message!));
      }
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
