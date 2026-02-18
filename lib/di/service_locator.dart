import 'package:get/get.dart';

// Services
import '../data/local/local_database.dart';
import '../data/remote/api_service.dart';
import '../data/remote/auth_service.dart';
import '../data/repository/course_repository.dart';
import '../data/repository/user_repository.dart';
import '../data/repository/progress_repository.dart';
import '../domain/usecases/srs_usecase.dart';
import '../domain/usecases/achievement_usecase.dart';
import '../utils/notification_service.dart';
import '../utils/analytics_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    // Core
    Get.lazyPut<LocalDatabase>(() => LocalDatabase(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);

    // Repositories
    Get.lazyPut<CourseRepository>(() => CourseRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<ProgressRepository>(() => ProgressRepository());

    // Use Cases
    Get.lazyPut<SrsUseCase>(() => SrsUseCase());
    Get.lazyPut<AchievementUseCase>(() => AchievementUseCase());

    // Utils
    Get.lazyPut<NotificationService>(() => NotificationService());
    Get.lazyPut<AnalyticsService>(() => AnalyticsService());

    // Initialize database
    await Get.find<LocalDatabase>().init();
  }
}

// Getters for convenience
LocalDatabase get localDb => Get.find<LocalDatabase>();
ApiService get apiService => Get.find<ApiService>();
AuthService get authService => Get.find<AuthService>();
CourseRepository get courseRepo => Get.find<CourseRepository>();
UserRepository get userRepo => Get.find<UserRepository>();
ProgressRepository get progressRepo => Get.find<ProgressRepository>();
SrsUseCase get srsUseCase => Get.find<SrsUseCase>();
AchievementUseCase get achievementUseCase => Get.find<AchievementUseCase>();
NotificationService get notificationService => Get.find<NotificationService>();
AnalyticsService get analyticsService => Get.find<AnalyticsService>();
