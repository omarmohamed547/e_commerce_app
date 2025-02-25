import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/domain/usecases/add_cart_useCase.dart';
import 'package:e_commerce_app/domain/usecases/get_product_useCase.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable // ✅ Add this annotation

class ProductTabViewmodel extends Cubit<ProductTabStates> {
  GetProductUsecase getProductUsecase;
  AddCartUsecase addCartUsecase;
  ProductTabViewmodel(
      {required this.getProductUsecase, required this.addCartUsecase})
      : super(IntialProductTabState());
  List<DatumProductEntity> productList = [];
  int numOfCartItems = 0;

  static ProductTabViewmodel get(context) =>
      BlocProvider.of<ProductTabViewmodel>(context);
  getProduct() async {
    emit(LoadingProductTabState());

    var either = await getProductUsecase.invoke();

    either.fold((error) {
      emit(FailureProductTabState(error: error));
    }, (response) {
      productList = response.data!;
      emit(SuccessProductTabState(responseEntity: response));
    });
  }

  addToCart(String productId) async {
    emit(LoadingAddCartState());

    var either = await addCartUsecase.invoke(productId);

    either.fold((error) {
      emit(FailureAddCartState(error: error));
    }, (response) {
      numOfCartItems = response.numOfCartItems!.toInt();
      print('num:$numOfCartItems');
      emit(SuccessAddCartState(responseEntity: response));
    });
  }
}
