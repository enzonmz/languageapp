class AuthService {
  // Mock auth for demo - replace with real Firebase Auth
  Future<bool> signInWithEmail(String email, String password) async {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> signOut() async {}

  Future<String?> getCurrentUserId() async {
    return 'demo-user';
  }
}
