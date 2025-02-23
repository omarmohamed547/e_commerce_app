import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/product/product_dataSource.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/either.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponseEntity>> getProduct();
}
