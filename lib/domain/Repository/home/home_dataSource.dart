import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/AddCart_entity.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';
import 'package:either_dart/either.dart';

abstract class HomeDatasource {
  Future<Either<Failure, CategoryOrBrandRespnseEntity>> getCategories();
  Future<Either<Failure, CategoryOrBrandRespnseEntity>> getBrands();
  Future<Either<Failure, AddProductCartResponseEntity>> addCart(
      String productId);
}
