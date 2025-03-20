import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/AddCart_entity.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';

class ProductTabStates {}

class IntialProductTabState extends ProductTabStates {}

class LoadingProductTabState extends ProductTabStates {}

class FailureProductTabState extends ProductTabStates {
  Failure error;
  FailureProductTabState({required this.error});
}

class SuccessProductTabState extends ProductTabStates {
  ProductResponseEntity responseEntity;
  SuccessProductTabState({required this.responseEntity});
}

class IntialAddCartState extends ProductTabStates {}

class LoadingAddCartState extends ProductTabStates {}

class FailureAddCartState extends ProductTabStates {
  Failure error;
  FailureAddCartState({required this.error});
}

class SuccessAddCartState extends ProductTabStates {
  AddProductCartResponseEntity responseEntity;
  SuccessAddCartState({required this.responseEntity});
}

class SucessLastUpdateAddCartState extends ProductTabStates {}
