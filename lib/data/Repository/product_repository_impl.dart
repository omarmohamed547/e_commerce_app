import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/product/product_dataSource.dart';
import 'package:e_commerce_app/domain/Repository/product/product_repository.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductDatasource productDatasource;
  ProductRepositoryImpl({required this.productDatasource});
  @override
  Future<Either<Failure, ProductResponseEntity>> getProduct() async {
    var either = await productDatasource.getProduct();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
