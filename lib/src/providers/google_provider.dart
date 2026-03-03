import 'package:firebase_auth/firebase_auth.dart';
import 'package:gd_login/src/providers/i_auth_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

final class GoogleProvider implements IAuthProvider {
  @override
  Future<UserCredential?> login(FirebaseAuth auth,
      {String? token, String? user, String? password}) async {
    try {
      await GoogleSignIn.instance.initialize();
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
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
