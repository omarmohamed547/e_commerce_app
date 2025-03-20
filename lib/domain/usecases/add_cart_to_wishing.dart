import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/wishing/Wishing_repos.dart';
import 'package:e_commerce_app/domain/entities/DeleteOrAddFavRespone_entity.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCartToWishingUsecase {
  WishingRepos wishingRepos;

  AddCartToWishingUsecase({required this.wishingRepos});
  Future<Either<Failure, DelteOrAddResponseFavouriteEntity>> invoke(
      String productId) {
    return wishingRepos.addCartToWishing(productId);
  }
}
