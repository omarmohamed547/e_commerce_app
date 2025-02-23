import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:either_dart/either.dart';

import '../../entities/product_entity.dart';

abstract class ProductDatasource {
  Future<Either<Failure, ProductResponseEntity>> getProduct();
}
