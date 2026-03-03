import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_login/src/providers/i_auth_provider.dart';

final class CredentialsProvider implements IAuthProvider {
  @override
  Future<UserCredential?> signup(FirebaseAuth auth,
      {String? token, String? user, String? password}) async {
    if (user != null && password != null) {
      try {
        return await auth.createUserWithEmailAndPassword(
          email: user,
          password: password,
        );
      } catch (e) {
        rethrow;
      }
    }
    return null;
  }

  @override
  Future<UserCredential?> login(FirebaseAuth auth,
      {String? token, String? user, String? password}) async {
    if (user != null && password != null) {
      try {
        return await auth.signInWithEmailAndPassword(
          email: user,
          password: password,
        );
      } catch (e) {
        rethrow;
      }
    }
    return null;
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
}
