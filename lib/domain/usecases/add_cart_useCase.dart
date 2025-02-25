import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/home/home_repository.dart';
import 'package:e_commerce_app/domain/Repository/product/product_repository.dart';
import 'package:e_commerce_app/domain/entities/AddCart_entity.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCartUsecase {
  HomeRepository homeRepository;
  AddCartUsecase({required this.homeRepository});
  Future<Either<Failure, AddProductCartResponseEntity>> invoke(
      String productId) {
    return homeRepository.addCart(productId);
  }
}
