import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/product/product_repository.dart';
import 'package:e_commerce_app/domain/Repository/wishing/Wishing_repos.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWishingUsecase {
  WishingRepos wishingRepos;
  GetWishingUsecase({required this.wishingRepos});
  Future<Either<Failure, GetWishingResponseEntity>> invoke() {
    return wishingRepos.getWishing();
  }
}
