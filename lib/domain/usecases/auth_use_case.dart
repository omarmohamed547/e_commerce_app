import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/Repository/auth/auth_repository.dart';
import 'package:e_commerce_app/domain/entities/login_mode.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, RegisterModelEntity>> invoke(String name, String email,
      String password, String rePassword, String phone) {
    return authRepository.register(name, email, password, rePassword, phone);
  }
}

@injectable
class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Failure, LoginModelEntity>> invoke( String email,
      String password) {
    return authRepository.login( email, password);
  }
}
