import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';

class RegisterStates {}

class IntialRegisterStates extends RegisterStates {}

class LoadingRegisterStates extends RegisterStates {}

class FailureRegisterStates extends RegisterStates {
  Failure error;
  FailureRegisterStates({required this.error});
}

class SucessRegisterStates extends RegisterStates {
  RegisterModelEntity registerModelEntity;
  SucessRegisterStates({required this.registerModelEntity});
}
