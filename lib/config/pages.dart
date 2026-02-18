import 'package:get/get.dart';
import '../config/routes.dart';
import '../presentation/pages/splash/splash_page.dart';
import '../presentation/pages/onboarding/onboarding_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/courses/courses_page.dart';
import '../presentation/pages/lesson/lesson_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.courses, page: () => const CoursesPage()),
    GetPage(name: AppRoutes.courseDetail, page: () => const CourseDetailPage()),
    GetPage(name: AppRoutes.lesson, page: () => const LessonPage()),
    GetPage(name: AppRoutes.exercise, page: () => const ExercisePage()),
    GetPage(name: AppRoutes.review, page: () => const ReviewPage()),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
    GetPage(name: AppRoutes.statistics, page: () => const StatisticsPage()),
  ];
}
