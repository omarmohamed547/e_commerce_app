import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/models/Product_response_modelDM.dart';
import 'package:e_commerce_app/domain/Repository/product/product_dataSource.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDatasource)
class ProductDatasourceImpl implements ProductDatasource {
  ApiManager apiManager;
  ProductDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, ProductResponseModelDm>> getProduct() async {
    try {
      var response =
          await apiManager.getData(apiEndpoints: ApiEndpoints.productendpoint);
      var productResponse = ProductResponseModelDm.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(productResponse);
      } else {
        return Left(Failure(errorMessage: productResponse.message!));
      }
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
