import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_repository.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUsecase {
  GetCartRepository cartRepository;
  GetCartUsecase({required this.cartRepository});
  Future<Either<Failure, GetCartResponseEntity>> invoke() {
    return cartRepository.getCart();
  }
}
