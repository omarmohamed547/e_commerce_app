import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_repository.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUsecase {
  final GetCartRepository getcartRepository;
  UpdateUsecase({required this.getcartRepository});

  Future<Either<Failure, GetCartResponseEntity>> invoke(
      String productId, int count) {
    return getcartRepository.updateCountInCart(productId, count);
  }
}
