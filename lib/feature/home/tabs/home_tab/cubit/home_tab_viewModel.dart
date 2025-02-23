import 'package:e_commerce_app/domain/usecases/get_brands_useCase.dart';
import 'package:e_commerce_app/domain/usecases/get_category_useCase.dart';
import 'package:e_commerce_app/feature/home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewmodel extends Cubit<HomeTabStates> {
  GetCategoryUsecase categoryUsecase;
  GetBrandsUsecase brandsUsecase;
  HomeTabViewmodel({required this.categoryUsecase, required this.brandsUsecase})
      : super(IntialHometabState());

  void getCategory() async {
    emit(LoadingCategoriesState());
    var either = await categoryUsecase.inovke();

    either.fold((error) {
      emit(FailureCategoriesState(error: error));
    }, (response) {
      emit(SuccessCategoriesState(responseEntity: response));
    });
  }

  void getBrands() async {
    emit(LoadingBrandsState());
    var either = await brandsUsecase.invoke();

    either.fold((error) {
      emit(FailureBrandsState(error: error));
    }, (response) {
      print("Fetching brands..."); // Debugging
      emit(SuccessBrandsState(responseEntity: response));
    });
  }
}
