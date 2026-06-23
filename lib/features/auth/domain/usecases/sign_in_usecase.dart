import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<User> execute(String email, String password) {
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (!email.contains('@')) {
      throw Exception('Invalid email address');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters long');
    }
    return repository.signIn(email, password);
  }
}
