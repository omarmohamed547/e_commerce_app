import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/home/home_repository.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBrandsUsecase {
  HomeRepository homeRepository;
  GetBrandsUsecase({required this.homeRepository});

  Future<Either<Failure, CategoryOrBrandRespnseEntity>> invoke() {
    return homeRepository.getBrands();
  }
}
