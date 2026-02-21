import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Stream<User?> onAuthStateChange();
  User? get currentUser;
}
