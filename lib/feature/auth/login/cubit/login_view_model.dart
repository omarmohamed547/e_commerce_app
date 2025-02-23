import 'package:e_commerce_app/domain/usecases/auth_use_case.dart';
import 'package:e_commerce_app/feature/auth/login/cubit/login_states.dart';
import 'package:e_commerce_app/feature/auth/register/cubit/register_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginViewModel({required this.loginUseCase})
      : super(IntialLoginStates());

  void login() async {
    if (formKey.currentState!.validate() == true) {

      try {
        emit(LoadingLoginStates());
        var either = await loginUseCase.invoke(
            emailController.text.trim(),
            passwordController.text.trim());

        either.fold((error) {
          emit(FailureLoginStates(error: error));
        }, (response) {
          emit(SucessLoginStates(loginModelEntity: response));
        });
      } catch (e) {

      }
    }
  }
}
