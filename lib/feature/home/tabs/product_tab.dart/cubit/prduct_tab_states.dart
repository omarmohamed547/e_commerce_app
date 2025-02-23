import 'package:e_commerce_app/core/utils/errors/failure.dart';
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
