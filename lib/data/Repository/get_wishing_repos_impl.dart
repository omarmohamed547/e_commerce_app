import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/wishing/Wishing_repos.dart';
import 'package:e_commerce_app/domain/Repository/wishing/wishing_dataSource.dart';
import 'package:e_commerce_app/domain/entities/DeleteOrAddFavRespone_entity.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishingRepos)
class GetWishingReposImpl implements WishingRepos {
  WishingDatasource wishingDatasource;
  GetWishingReposImpl({required this.wishingDatasource});
  @override
  Future<Either<Failure, GetWishingResponseEntity>> getWishing() async {
    return await wishingDatasource.getWishing();
  }

  @override
  Future<Either<Failure, DelteOrAddResponseFavouriteEntity>> addCartToWishing(
      String productId) async {
    return await wishingDatasource.addCartToWishing(productId);
  }

  @override
  Future<Either<Failure, DelteOrAddResponseFavouriteEntity>>
      deleteCartFromWishing(String productId) async {
    return await wishingDatasource.deleteCartFromWishing(productId);
  }
}
