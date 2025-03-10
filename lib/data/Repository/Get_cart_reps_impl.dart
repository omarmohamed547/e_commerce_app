import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_dataSource.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_repository.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:e_commerce_app/domain/usecases/delete_itemInCart_useCase.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCartRepository)
class GetCartRepsImpl implements GetCartRepository {
  final GetCartDatasource getCartDatasource;

  GetCartRepsImpl({required this.getCartDatasource});

  @override
  Future<Either<Failure, GetCartResponseEntity>> getCart() async {
    return await getCartDatasource.getCart();
  }

  @override
  Future<Either<Failure, GetCartResponseEntity>> deleteItemInCart(
      String productId) async {
    return await getCartDatasource.deleteItemInCart(productId);
  }

  @override
  Future<Either<Failure, GetCartResponseEntity>> updateCountInCart(
      String productId, int count) async {
    return await getCartDatasource.updateCountInCart(productId, count);
  }
}
