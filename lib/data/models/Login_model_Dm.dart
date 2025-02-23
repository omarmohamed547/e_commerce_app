import 'package:e_commerce_app/domain/entities/login_mode.dart';

class LoginModelDm extends LoginModelEntity {
  LoginModelDm({
    required super.message,
    required super.user,
    required super.token,
    required super.statusMessage,

  });



  factory LoginModelDm.fromJson(Map<String, dynamic> json){
    return LoginModelDm(
      statusMessage: json["statusMsg"],

      message: json["message"],
      user: json["user"] == null ? null : UserLoginDm.fromJson(json["user"]),
      token: json["token"],
    );
  }


}

class UserLoginDm extends UserLoginEntity{
  UserLoginDm({
    required super.name,
    required super.email,
    required this.role,
  });


  final String? role;

  factory UserLoginDm.fromJson(Map<String, dynamic> json){
    return UserLoginDm(
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }


}
