import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/Get_cart_entity.dart';

abstract class CartStates {}

class LoadingCartState extends CartStates {}

class FailureCartState extends CartStates {
  Failure error;
  FailureCartState({required this.error});
}

class SucessCartState extends CartStates {
  GetCartResponseEntity getCartResponseEntity;
  SucessCartState({required this.getCartResponseEntity});
}
