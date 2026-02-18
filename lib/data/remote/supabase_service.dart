import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../config/supabase.dart';

class SupabaseService {
  static SupabaseClient? _client;

  static Future<void> initialize() async {
    if (_client == null) {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
      _client = Supabase.instance.client;
    }
  }

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _client!;
  }

  // Регистрация пользователя
  static Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Вход пользователя
  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Выход
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Получить текущего пользователя
  static User? get currentUser => client.auth.currentUser;

  // Получить сессию
  static Session? get currentSession => client.auth.currentSession;

  // Stream изменений авторизации
  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  // Получить ID пользователя
  static String? get userId => client.auth.currentUser?.id;

  // Проверить авторизован ли пользователь
  static bool get isAuthenticated => client.auth.currentSession != null;
}
