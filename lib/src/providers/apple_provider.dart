import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_login/src/providers/i_auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final class AppleProvider implements IAuthProvider {
  @override
  Future<UserCredential?> login(FirebaseAuth auth,
      {String? token, String? user, String? password}) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await auth.signInWithCredential(oauthCredential);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> refresh(FirebaseAuth auth, User user,
      {String? token, String? refreshToken}) async {
    try {
      await user.reload();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> signup(FirebaseAuth auth,
          {String? token, String? user, String? password}) =>
      login(auth);
}
