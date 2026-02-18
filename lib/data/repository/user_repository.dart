import '../local/local_database.dart';
import '../remote/api_service.dart';
import '../../utils/analytics_service.dart';
import '../../domain/models/user.dart';

class UserRepository {
  UserRepository({
    LocalDatabase? localDatabase,
    ApiService? apiService,
    AnalyticsService? analyticsService,
  })  : _localDatabase = localDatabase ?? LocalDatabase(),
        _apiService = apiService ?? ApiService(),
        _analytics = analyticsService ?? AnalyticsService();
  final LocalDatabase _localDatabase;
  final ApiService _apiService;
  final AnalyticsService _analytics;

  Future<AppUser?> getCurrentUser(String userId) async {
    final userData = await _localDatabase.getUser(userId);
    if (userData != null) {
      return AppUser.fromJson(userData);
    }
    return null;
  }

  Future<AppUser> createUser(String userId, AppUser user) async {
    await _localDatabase.saveUser(userId, user.toJson());
    return user;
  }

  Future<void> updateUser(String userId, AppUser user) async {
    final updatedUser = user.copyWith(updatedAt: DateTime.now());
    await _localDatabase.saveUser(userId, updatedUser.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _localDatabase.deleteUser(userId);
  }

  Future<void> updateStreak(String userId, int newStreak) async {
    final userData = await _localDatabase.getUser(userId);
    if (userData != null) {
      final user = AppUser.fromJson(userData);
      await updateUser(userId, user.copyWith(streak: newStreak));
    }
  }
}
