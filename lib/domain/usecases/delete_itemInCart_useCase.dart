import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_repository.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteItemincartUsecase {
  final GetCartRepository getcartRepository;
  DeleteItemincartUsecase({required this.getcartRepository});

  Future<Either<Failure, GetCartResponseEntity>> invoke(String productId) {
    return getcartRepository.deleteItemInCart(productId);
  }
}