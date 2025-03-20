import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/domain/usecases/Get_wishing_useCase.dart';
import 'package:e_commerce_app/domain/usecases/add_cart_to_wishing.dart';
import 'package:e_commerce_app/domain/usecases/delete_cart_wishing.dart';
import 'package:e_commerce_app/feature/home/tabs/Heart_tab/cubit/wishing_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

@injectable // ✅ Add this annotation

class WishingViewmodel extends Cubit<WishingStates> {
  GetWishingUsecase getWishingUsecase;
  DeleteCartWishingUseCase deleteCartWishingUseCase;

  AddCartToWishingUsecase addCartToWishingUsecase;
  WishingViewmodel(
      {required this.deleteCartWishingUseCase,
      required this.getWishingUsecase,
      required this.addCartToWishingUsecase})
      : super(LoadingWishingState());
  Set<String> favoriteProductIds = {}; // ✅ Store wishlist product IDs
  List<DatumProductEntity> wishingList = [];
  static WishingViewmodel get(context) =>
      BlocProvider.of<WishingViewmodel>(context);
  getWishing() async {
    emit(LoadingWishingState());

    var either = await getWishingUsecase.invoke();

    either.fold((error) {
      emit(FailureWishingState(error: error));
    }, (response) {
      favoriteProductIds = response.data?.map((e) => e.id ?? "").toSet() ?? {};
      wishingList = response.data ?? [];
      emit(SuccessWishingState(getWishingResponseEntity: response));
    });
  }

  addToWishing(DatumProductEntity product) async {
    emit(LoadingAddingWishingState());

    var either = await addCartToWishingUsecase.invoke(product.id ?? "");
    either.fold((error) {
      emit(FailureAddingWishingState(error: error));
    }, (response) {
      // ✅ Toggle product favorite status
      if (!favoriteProductIds.contains(product.id ?? "")) {
        wishingList.add(product);
        favoriteProductIds.add(product.id ?? "");
      }
      emit(SucessAddingWishingState(wishList: wishingList));
    });
  }

  deleteFromWishing(DatumProductEntity product) async {
    var either = await deleteCartWishingUseCase.invoke(product.id ?? "");

    either.fold((error) {
      print("Delete API Error: $error");
      emit(FailureDeletedWishingState(error: error));
    }, (response) {
      print("Delete Success: $response");

      if (favoriteProductIds.contains(product.id ?? "")) {
        // ✅ Remove the item from the list directly
        wishingList.removeWhere((item) => item.id == product.id);
        favoriteProductIds.remove(product.id ?? "");

        // ✅ Emit a new success state with the updated list
        emit(SucessDeltedWishingState(wishList: wishingList));
      }
    });
  }

  /// Checks if an item is in the wishlist
  bool isFavorite(String productId) {
    return favoriteProductIds.contains(productId);
  }
}
