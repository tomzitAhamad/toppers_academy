import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<void> execute(String email) {
    if (email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (!email.contains('@')) {
      throw Exception('Invalid email address');
    }
    return repository.sendPasswordResetEmail(email);
  }
}
