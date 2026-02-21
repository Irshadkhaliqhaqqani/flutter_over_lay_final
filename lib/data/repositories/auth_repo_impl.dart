import 'package:figma_overlay_clean/domain/repositories/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  final _client = Supabase.instance.client;

  @override
  Future<void> signIn(String email, String password) async {
    await _client.auth.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> signOut() async => await _client.auth.signOut();

  @override
  Future<void> signUp(
    String email,
    String password,
  ) async {
    await _client.auth.signUp(
      password: password,
      email: email,
    );
  }

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<User?> onAuthStateChange() {
    return _client.auth.onAuthStateChange.map((data) => data.session?.user);
  }
}
