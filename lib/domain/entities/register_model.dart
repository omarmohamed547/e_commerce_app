class RegisterModelEntity {
  RegisterModelEntity({
    required this.message,
    required this.user,
    required this.token,
    required this.statusMessage,
  });

  final String? message;
  final UserModelEntity? user;
  final String? token;

  final String? statusMessage;
}

class UserModelEntity {
  UserModelEntity({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;
}
