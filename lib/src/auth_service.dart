import 'package:gd_http_client/gd_http_client.dart';
import 'models/auth_result.dart';
import 'models/login_credentials.dart';

/// Authentication service for email/password and social login
abstract class AuthService {
  final IHttpClient httpClient;

  AuthService(this.httpClient);

  /// Login with email and password
  Future<AuthResult> loginWithEmail(LoginCredentials credentials);

  /// Login with Google
  Future<AuthResult> loginWithGoogle(String token);

  /// Login with Facebook
  Future<AuthResult> loginWithFacebook(String token);

  /// Logout current user
  Future<void> logout();
}

/// Default implementation of AuthService
class DefaultAuthService extends AuthService {
  final String baseUrl;

  DefaultAuthService(super.httpClient, {required this.baseUrl});

  @override
  Future<AuthResult> loginWithEmail(LoginCredentials credentials) async {
    final response = await httpClient.post(
      '$baseUrl/auth/login',
      data: credentials.toJson(),
    );

    if (response.statusCode == 200) {
      return AuthResult.fromJson(response.data);
    }
    throw Exception('Login failed: ${response.statusCode}');
  }

  @override
  Future<AuthResult> loginWithGoogle(String token) async {
    final response = await httpClient.post(
      '$baseUrl/auth/google',
      data: {'token': token},
    );

    if (response.statusCode == 200) {
      return AuthResult.fromJson(response.data);
    }
    throw Exception('Google login failed: ${response.statusCode}');
  }

  @override
  Future<AuthResult> loginWithFacebook(String token) async {
    final response = await httpClient.post(
      '$baseUrl/auth/facebook',
      data: {'token': token},
    );

    if (response.statusCode == 200) {
      return AuthResult.fromJson(response.data);
    }
    throw Exception('Facebook login failed: ${response.statusCode}');
  }

  @override
  Future<void> logout() async {
    await httpClient.post('$baseUrl/auth/logout');
  }
}
