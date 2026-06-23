import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }
}
