import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Static mock logic: always succeed and return the static user 'Nafiz'
    return UserModel(
      email: email.isNotEmpty ? email : 'your.email@example.com',
      name: 'Nafiz',
    );
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate potential server error (just checking email syntax for demo)
    if (!email.contains('.')) {
      throw Exception('Server failed to verify domain');
    }
  }
}
