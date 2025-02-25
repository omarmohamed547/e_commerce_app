import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_dataSource.dart';
import 'package:e_commerce_app/domain/Repository/cart/cart_repository.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCartRepository)
class GetCartRepsImpl implements GetCartRepository {
  GetCartDatasource getCartDatasource;
  GetCartRepsImpl({required this.getCartDatasource});
  @override
  Future<Either<Failure, GetCartResponseEntity>> getCart() async {
    var either = await getCartDatasource.getCart();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
