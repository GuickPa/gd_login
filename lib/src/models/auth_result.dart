/// Result of authentication operation
class AuthResult {
  final String token;
  final String userId;
  final String? refreshToken;

  AuthResult({
    required this.token,
    required this.userId,
    this.refreshToken,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) => AuthResult(
        token: json['token'] as String,
        userId: json['userId'] as String,
        refreshToken: json['refreshToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'userId': userId,
        'refreshToken': refreshToken,
      };
}
