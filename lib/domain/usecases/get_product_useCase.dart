import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/product/product_repository.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUsecase {
  ProductRepository productRepository;
  GetProductUsecase({required this.productRepository});
  Future<Either<Failure, ProductResponseEntity>> invoke() {
    return productRepository.getProduct();
  }
}
