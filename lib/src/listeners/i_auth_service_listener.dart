import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthServiceListener {
  /// Called when login is successful
  void onLoginSuccess(User result);

  /// Called when login fails
  void onLoginFailure(String error);

  /// Called when logout is successful
  void onLogoutSuccess();

  /// Called when logout fails
  void onLogoutFailure(String error);
}
