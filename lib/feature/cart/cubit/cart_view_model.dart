import 'package:e_commerce_app/domain/usecases/Update_usecase.dart';
import 'package:e_commerce_app/domain/usecases/delete_itemInCart_useCase.dart';
import 'package:e_commerce_app/domain/usecases/get_cart_useCase.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartViewModel extends Cubit<CartStates> {
  GetCartUsecase getCartUsecase;
  DeleteItemincartUsecase deleteItemincartUsecase;
  UpdateUsecase updateUsecase;
  CartViewModel(
      {required this.getCartUsecase,
      required this.deleteItemincartUsecase,
      required this.updateUsecase})
      : super(LoadingCartState());
  static CartViewModel get(context) => BlocProvider.of<CartViewModel>(context);

  void getItems() async {
    emit(LoadingCartState());

    var either = await getCartUsecase.invoke();

    either.fold((error) {
      emit(FailureCartState(error: error));
    }, (response) {
      emit(SucessCartState(getCartResponseEntity: response));
    });
  }

  void deleteItems(String productId, BuildContext context) async {
    var either = await deleteItemincartUsecase.invoke(productId);

    either.fold((error) {
      emit(FailureCartState(error: error));
    }, (response) {
      ProductTabViewmodel.get(context).numOfCartItems =
          response.numOfCartItems!.toInt();
      ProductTabViewmodel.get(context)
          .emit(SucessLastUpdateAddCartState()); // Notify UI update

      emit(SucessCartState(getCartResponseEntity: response));
    });
  }

  void update(String productId, int count, BuildContext context) async {
    var either = await updateUsecase.invoke(productId, count);

    either.fold((error) {
      emit(FailureCartState(error: error));
    }, (response) {
      ProductTabViewmodel.get(context).numOfCartItems =
          response.numOfCartItems!.toInt();
      emit(SucessCartState(getCartResponseEntity: response));
    });
  }
}
