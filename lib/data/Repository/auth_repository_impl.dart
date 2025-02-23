import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/auth/auth_remote_dataSource.dart';
import 'package:e_commerce_app/domain/Repository/auth/auth_repository.dart';
import 'package:e_commerce_app/domain/entities/login_mode.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, RegisterModelEntity>> register(String name,
      String email, String password, String rePassword, String phone) async {
    var either = await authRemoteDatasource.register(
        name, email, password, rePassword, phone);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, LoginModelEntity>> login(String email,
      String password)async {
    var either = await authRemoteDatasource.login(
         email, password);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}