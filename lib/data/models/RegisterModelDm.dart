import 'package:e_commerce_app/domain/entities/register_model.dart';

class RegisterModelDM extends RegisterModelEntity {
  RegisterModelDM({
    required super.message,
    required super.user,
    required super.token,
    required super.statusMessage,
  });

  factory RegisterModelDM.fromJson(Map<String, dynamic> json) {
    return RegisterModelDM(
      message: json["message"],
      user: json["user"] == null ? null : UserdM.fromJson(json["user"]),
      token: json["token"],
      statusMessage: json["statusMsg"],
    );
  }
}

class UserdM extends UserModelEntity {
  UserdM({
    required super.name,
    required super.email,
    required this.role,
  });

  final String role;

  factory UserdM.fromJson(Map<String, dynamic> json) {
    return UserdM(
      name: json["name"],
      email: json["email"],
      role: json["role"],
    );
  }
}
