import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthProvider {
  Future<UserCredential?> signup(FirebaseAuth auth,
      {String? token, String? user, String? password});

  Future<UserCredential?> login(FirebaseAuth auth,
      {String? token, String? user, String? password});

  Future<void> refresh(FirebaseAuth auth, User user,
      {String? token, String? refreshToken});
}
