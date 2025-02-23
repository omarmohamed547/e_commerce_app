import 'package:e_commerce_app/domain/entities/product_entity.dart';
import 'package:e_commerce_app/domain/usecases/get_product_useCase.dart';
import 'package:e_commerce_app/feature/home/tabs/product_tab.dart/cubit/prduct_tab_states.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable // ✅ Add this annotation

class ProductTabViewmodel extends Cubit<ProductTabStates> {
  GetProductUsecase getProductUsecase;
  ProductTabViewmodel({required this.getProductUsecase})
      : super(IntialProductTabState());
  List<DatumProductEntity> productList = [];
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
}
