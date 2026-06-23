import 'package:flutter/material.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';

class AuthController extends ChangeNotifier {
  final SignInUseCase signInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthController({
    required this.signInUseCase,
    required this.forgotPasswordUseCase,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _passwordResetSent = false;
  bool get passwordResetSent => _passwordResetSent;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await signInUseCase.execute(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    _passwordResetSent = false;
    notifyListeners();

    try {
      await forgotPasswordUseCase.execute(email);
      _isLoading = false;
      _passwordResetSent = true;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
