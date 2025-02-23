import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/data_sources/home_dataSource_impl.dart';
import 'package:e_commerce_app/domain/Repository/home/home_dataSource.dart';
import 'package:e_commerce_app/domain/Repository/home/home_repository.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeDatasource homeDatasource;
  HomeRepositoryImpl({required this.homeDatasource});
  @override
  Future<Either<Failure, CategoryOrBrandRespnseEntity>> getCategories() async {
    var either = await homeDatasource.getCategories();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, CategoryOrBrandRespnseEntity>> getBrands() async {
    var either = await homeDatasource.getBrands();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
