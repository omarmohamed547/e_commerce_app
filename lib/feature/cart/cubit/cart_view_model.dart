import 'package:e_commerce_app/domain/usecases/Update_usecase.dart';
import 'package:e_commerce_app/domain/usecases/delete_itemInCart_useCase.dart';
import 'package:e_commerce_app/domain/usecases/get_cart_useCase.dart';
import 'package:e_commerce_app/feature/cart/cubit/cart_states.dart';
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

  void deleteItems(String productId) async {
    var either = await deleteItemincartUsecase.invoke(productId);

    either.fold((error) {
      emit(FailureCartState(error: error));
    }, (response) {
      emit(SucessCartState(getCartResponseEntity: response));
    });
  }

  void update(String productId, int count) async {
    var either = await updateUsecase.invoke(productId, count);

    either.fold((error) {
      emit(FailureCartState(error: error));
    }, (response) {
      emit(SucessCartState(getCartResponseEntity: response));
    });
  }
}
