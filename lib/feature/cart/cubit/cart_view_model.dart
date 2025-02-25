import 'package:e_commerce_app/feature/cart/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewModel extends Cubit<CartStates> {
  CartViewModel() : super(LoadingCartState());
}
