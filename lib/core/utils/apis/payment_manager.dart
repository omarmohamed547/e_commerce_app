import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class PaymobManager {
  static final Dio _dio = Dio();
  static const String _baseUrl = 'https://accept.paymob.com/api';

  // Replace with your actual Paymob API key and integration ID
  static const String _apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBek5USTVPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5TQU5GOWp5Mzl2OWpBTjBqN3lzREpvRTBoQUE4a01lUF9JU2xsWVZNMUd5QWoxVllCUWtYQzh2UnNweGZFSWJtT0xzMm5YUUxJSmFYOTduZ0VkOERKZw==";
  static const int _integrationId = 5034794;

  static String? _authToken;

  Future<Response> postDataPayment(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Map<String, dynamic>? headers,
      Options? options}) {
    return _dio.post(_baseUrl + apiEndpoints,
        data: body,
        options: Options(validateStatus: (status) => true, headers: headers),
        queryParameters: queryParameters);
  }

  /// Step 1: Get Auth Token
  static Future<String?> getToken() async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/tokens',
        data: {'api_key': _apiKey},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _authToken = response.data['token'];
        return _authToken;
      } else {
        print('Token Error: ${response.statusCode} ${response.data}');
        return null;
      }
    } catch (e) {
      print('Token Exception: $e');
      return null;
    }
  }

  /// Step 2: Create Order ID
  static Future<int?> createOrderId({
    required int amountCents,
    String currency = 'EGP',
  }) async {
    try {
      final token = _authToken ?? await getToken();
      if (token == null) return null;

      final response = await _dio.post(
        '$_baseUrl/ecommerce/orders',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'auth_token': token,
          'delivery_needed': false,
          'amount_cents': amountCents,
          'currency': currency,
          'items': [],
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data['id'];
      } else {
        print('Order Error: ${response.statusCode} ${response.data}');
        return null;
      }
    } catch (e) {
      print('Order Exception: $e');
      return null;
    }
  }

  /// Step 3: Get Payment Key
  static Future<String?> getPaymentKey({
    required int amountCents,
    required int orderId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    String currency = 'EGP',
  }) async {
    try {
      final token = _authToken ?? await getToken();
      if (token == null) return null;

      final response = await _dio.post(
        '$_baseUrl/acceptance/payment_keys',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'auth_token': token,
          'amount_cents': amountCents,
          'expiration': 3600,
          'order_id': orderId,
          'billing_data': {
            "apartment": "NA",
            "email": email,
            "floor": "NA",
            "first_name": firstName,
            "street": "NA",
            "building": "NA",
            "phone_number": phoneNumber,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": lastName,
            "state": "NA"
          },
          'currency': currency,
          'integration_id': _integrationId,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data['token'];
      } else {
        print('PaymentKey Error: ${response.statusCode} ${response.data}');
        return null;
      }
    } catch (e) {
      print('PaymentKey Exception: $e');
      return null;
    }
  }
}
