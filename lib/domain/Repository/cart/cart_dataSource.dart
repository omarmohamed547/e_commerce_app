import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/either.dart';

abstract class GetCartDatasource {
  Future<Either<Failure, GetCartResponseEntity>> getCart();
}
