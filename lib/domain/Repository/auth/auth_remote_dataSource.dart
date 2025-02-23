import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';
import 'package:either_dart/either.dart';

import '../../entities/login_mode.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, RegisterModelEntity>> register(String name,
      String email, String password, String rePassword, String phone);

  Future<Either<Failure, LoginModelEntity>> login(
      String email, String password);

}
