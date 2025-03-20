import 'package:e_commerce_app/core/utils/cache/shared_pref.dart';
import 'package:e_commerce_app/domain/usecases/auth_use_case.dart';
import 'package:e_commerce_app/feature/auth/register/cubit/register_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase registerUseCase;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repaswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterViewModel({required this.registerUseCase})
      : super(IntialRegisterStates());
  static RegisterViewModel get(context) =>
      BlocProvider.of<RegisterViewModel>(context);

  void register() async {
    if (formKey.currentState!.validate() == true) {
      try {
        emit(LoadingRegisterStates());
        var either = await registerUseCase.invoke(
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim(),
            repaswordController.text.trim(),
            phoneController.text.trim());

        either.fold((error) {
          emit(FailureRegisterStates(error: error));
        }, (response) async {
          await SharedPrefernceUtilis.saveData(
              "name", nameController.text.trim());
          await SharedPrefernceUtilis.saveData(
              "email", emailController.text.trim());
          await SharedPrefernceUtilis.saveData(
              "phone", phoneController.text.trim());
          await SharedPrefernceUtilis.saveData(
              "password", passwordController.text.trim());

          emit(SucessRegisterStates(registerModelEntity: response));
        });
      } catch (e) {}
    }
  }
}
