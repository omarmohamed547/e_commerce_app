import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/DeleteOrAddFavRespone_entity.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:either_dart/either.dart';

abstract class WishingRepos {
  Future<Either<Failure, GetWishingResponseEntity>> getWishing();
  Future<Either<Failure, DelteOrAddResponseFavouriteEntity>> addCartToWishing(
      String productId);

  Future<Either<Failure, DelteOrAddResponseFavouriteEntity>>
      deleteCartFromWishing(String productId);
}
