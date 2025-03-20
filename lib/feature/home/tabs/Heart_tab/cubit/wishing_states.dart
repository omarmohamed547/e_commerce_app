import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/domain/entities/Get_wishing_entity.dart';
import 'package:e_commerce_app/domain/entities/product_entity.dart';

abstract class WishingStates {}

class LoadingWishingState extends WishingStates {}

class FailureWishingState extends WishingStates {
  Failure error;
  FailureWishingState({required this.error});
}

class SuccessWishingState extends WishingStates {
  GetWishingResponseEntity getWishingResponseEntity;
  SuccessWishingState({required this.getWishingResponseEntity});
}

class LoadingAddingWishingState extends WishingStates {}

class FailureAddingWishingState extends WishingStates {
  Failure error;
  FailureAddingWishingState({required this.error});
}

class SucessAddingWishingState extends WishingStates {
  List<DatumProductEntity> wishList;
  SucessAddingWishingState({required this.wishList});
}

class LoadingDeltedWishingState extends WishingStates {}

class FailureDeletedWishingState extends WishingStates {
  Failure error;
  FailureDeletedWishingState({required this.error});
}

class SucessDeltedWishingState extends WishingStates {
  List<DatumProductEntity> wishList;
  SucessDeltedWishingState({required this.wishList});
}
