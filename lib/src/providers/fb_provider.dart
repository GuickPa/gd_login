import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_login/src/providers/i_auth_provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final class FBProvider implements IAuthProvider {
  @override
  Future<UserCredential?> login(FirebaseAuth auth,
      {String? token, String? user, String? password}) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        throw Exception('Facebook login failed');
      }

      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.token,
      );

      return await auth.signInWithCredential(credential);
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
