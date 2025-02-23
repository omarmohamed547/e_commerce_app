import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/models/category_or_brand_modelDm.dart';
import 'package:e_commerce_app/domain/Repository/home/home_dataSource.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDatasource)
class HomeDatasourceImpl implements HomeDatasource {
  ApiManager apiManager;
  HomeDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, CategoryOrBrandResponseDm>> getCategories() async {
    try {
      var response =
          await apiManager.getData(apiEndpoints: ApiEndpoints.categoryendpoint);
      var categoryResponse = CategoryOrBrandResponseDm.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(categoryResponse);
      } else {
        return Left(Failure(errorMessage: categoryResponse.message!));
      }
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryOrBrandRespnseEntity>> getBrands() async {
    try {
      var response =
          await apiManager.getData(apiEndpoints: ApiEndpoints.brandendpoint);
      var brandResponse = CategoryOrBrandResponseDm.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(brandResponse);
      } else {
        return Left(Failure(errorMessage: brandResponse.message!));
      }
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
