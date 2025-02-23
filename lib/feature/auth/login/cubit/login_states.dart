import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/login_mode.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';

class LoginStates {}

class IntialLoginStates extends LoginStates {}

class LoadingLoginStates extends LoginStates {}

class FailureLoginStates extends LoginStates {
  Failure error;
  FailureLoginStates({required this.error});
}

class SucessLoginStates extends LoginStates {
  LoginModelEntity loginModelEntity;
  SucessLoginStates({required this.loginModelEntity});
}
