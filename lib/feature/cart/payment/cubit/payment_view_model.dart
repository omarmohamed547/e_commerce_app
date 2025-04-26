import 'package:e_commerce_app/core/utils/apis/api_constant.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/apis/payment_manager.dart';
import 'package:e_commerce_app/feature/cart/payment/cubit/payment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentViewModel extends Cubit<PaymentStates> {
  PaymentViewModel({required this.paymobManager}) : super(IntialPayment());
  PaymobManager paymobManager;
  String? authToken;
  String? orderId;
  String? finalToken;

  static PaymentViewModel get(context) =>
      BlocProvider.of<PaymentViewModel>(context);

  Future<void> completePaymentFlow(int price) async {
    try {
      await getAuthToken();
      if (authToken == null) return;

      await createOrderId(price: price);
      if (orderId == null) return;

      await getPaymentKey(price: price);
    } catch (e) {
      emit(FailureRequestTokenPaymentState());
      rethrow;
    }
  }

  Future<void> getAuthToken() async {
    emit(LoadingAuthTokenPaymentState());

    try {
      final response = await paymobManager.postDataPayment(
        apiEndpoints: "/api/auth/tokens",
        body: {"api_key": ApiConstant.apiKey},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        authToken = response.data['token'];
        emit(SuccessAuthTokenPaymentState());
        debugPrint("✅ Auth Token: $authToken");
      } else {
        throw Exception("Failed to get auth token: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Auth Token Error: $e");
      emit(FailureAuthTokenPaymentState());
      throw Exception("Authentication failed");
    }
  }

  Future<void> createOrderId({required int price}) async {
    emit(LoadingOrderIdPaymentState());

    try {
      final response = await paymobManager.postDataPayment(
        apiEndpoints: "/api/ecommerce/orders",
        body: {
          "auth_token": authToken,
          "delivery_needed": "false",
          "amount_cents": price.toString(),
          "currency": "EGP",
          "items": [],
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        orderId = response.data['id'].toString();
        emit(SuccessOrderIdPaymentState());
        debugPrint("✅ Order ID: $orderId");
      } else {
        throw Exception("Order creation failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Order Creation Error: $e");
      emit(FailureOrderIdPaymentState());
      throw Exception("Failed to create order");
    }
  }

  Future<void> getPaymentKey({required int price}) async {
    emit(LoadingRequestTokenPaymentState());

    try {
      final response = await paymobManager.postDataPayment(
        apiEndpoints: "/api/acceptance/payment_keys",
        body: {
          "auth_token": authToken,
          "amount_cents": price.toString(),
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "803",
            "email": "user@example.com",
            "floor": "42",
            "first_name": "Omar",
            "street": "Sample Street",
            "building": "8028",
            "phone_number": "+201234567890",
            "shipping_method": "PKG",
            "postal_code": "01898",
            "city": "Cairo",
            "country": "EG",
            "last_name": "Mohamed",
            "state": "Cairo"
          },
          "currency": "EGP",
          "integration_id": 5034794
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        finalToken =
            "https://accept.paymob.com/api/acceptance/iframes/911482?payment_token=${response.data['token']}";
        emit(SuccessRequestTokenPaymentState());
        debugPrint("✅ Payment URL: $finalToken");
      } else {
        throw Exception("Payment key failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Payment Key Error: $e");
      emit(FailureRequestTokenPaymentState());
      throw Exception("Failed to get payment key");
    }
  }
}
