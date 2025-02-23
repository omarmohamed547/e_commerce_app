import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/apis/api_constant.dart';
import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  final dio = Dio();
  Future<Response> getData(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.get(ApiConstant.baseurl + apiEndpoints,
        options: Options(
          validateStatus: (status) => true,
        ),
        queryParameters: queryParameters);
  }

  Future<Response> postData(
      {required String apiEndpoints,
      Map<String, dynamic>? queryParameters,
      Object? body,
      Options? options}) {
    return dio.post(ApiConstant.baseurl + apiEndpoints,
        data: body,
        options: Options(
          validateStatus: (status) => true,
        ),
        queryParameters: queryParameters);
  }
}
