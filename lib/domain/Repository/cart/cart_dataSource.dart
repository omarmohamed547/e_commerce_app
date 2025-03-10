import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/either.dart';

abstract class GetCartDatasource {
  Future<Either<Failure, GetCartResponseEntity>> getCart();
  Future<Either<Failure, GetCartResponseEntity>> deleteItemInCart(
      String productId);
  Future<Either<Failure, GetCartResponseEntity>> updateCountInCart(
      String productId, int count);
}
