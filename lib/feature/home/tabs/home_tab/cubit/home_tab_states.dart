import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/category_or_brand_model.dart';

class HomeTabStates {}

class IntialHometabState extends HomeTabStates {}

class LoadingCategoriesState extends HomeTabStates {}

class LoadingBrandsState extends HomeTabStates {}

class FailureCategoriesState extends HomeTabStates {
  Failure error;
  FailureCategoriesState({required this.error});
}

class FailureBrandsState extends HomeTabStates {
  Failure error;
  FailureBrandsState({required this.error});
}

class SuccessCategoriesState extends HomeTabStates {
  CategoryOrBrandRespnseEntity responseEntity;
  SuccessCategoriesState({required this.responseEntity});
}

class SuccessBrandsState extends HomeTabStates {
  CategoryOrBrandRespnseEntity responseEntity;
  SuccessBrandsState({required this.responseEntity});
}
