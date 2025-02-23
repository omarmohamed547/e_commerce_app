class LoginModelEntity {
  LoginModelEntity({
    required this.message,
    required this.user,
    required this.token,
    required this.statusMessage,

  });

  final String? message;
  final UserLoginEntity? user;
  final String? token;
  final String? statusMessage;



}

class UserLoginEntity {
  UserLoginEntity({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;



}
