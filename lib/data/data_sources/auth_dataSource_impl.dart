import 'package:e_commerce_app/core/utils/apis/api_endpoints.dart';
import 'package:e_commerce_app/core/utils/apis/api_manager.dart';
import 'package:e_commerce_app/core/utils/errors/failure.dart';
import 'package:e_commerce_app/data/models/Login_model_Dm.dart';
import 'package:e_commerce_app/data/models/RegisterModelDm.dart';
import 'package:e_commerce_app/domain/Repository/auth/auth_remote_dataSource.dart';
import 'package:e_commerce_app/domain/entities/login_mode.dart';
import 'package:e_commerce_app/domain/entities/register_model.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthDatasourceImpl implements AuthRemoteDatasource {
  ApiManager apiManager;
  AuthDatasourceImpl({required this.apiManager});
  @override
  Future<Either<Failure, RegisterModelDM>> register(String name, String email,
      String password, String rePassword, String phone) async {
    try {
      var response = await apiManager
          .postData(apiEndpoints: ApiEndpoints.registerendpoint, body: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phone
      });
      var registerResponse = RegisterModelDM.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(registerResponse);
      } else {
        return Left(ServerError(errorMessage: registerResponse.message!));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModelDm>> login(String email, String password)async {
    try {
      var response = await apiManager
          .postData(apiEndpoints: ApiEndpoints.loginendpoint, body: {

        "email": email,
        "password": password,

      });
      var loginResponse = LoginModelDm.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(loginResponse);
      } else {
        return Left(ServerError(errorMessage: loginResponse.message!));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: "an error has occured"));
    }
  }

}
