import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/onboarding/onboarding_page.dart' as onboarding;
import 'presentation/pages/auth/login_page.dart' as auth;
import 'presentation/pages/auth/auth_controller.dart';
import 'presentation/pages/home/home_page.dart' as home;
import 'presentation/pages/courses/courses_page.dart' as courses;
import 'presentation/pages/courses/content_generator_page.dart';
import 'presentation/pages/lesson/lesson_page.dart' as lesson;
import 'presentation/pages/chat/chat_page.dart';
import 'presentation/pages/dashboard/dashboard_page.dart';

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Инициализация контроллеров
    Get.put(AuthController());

    return GetMaterialApp(
      title: 'Изучение языков',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
        GetPage(
            name: AppRoutes.onboarding,
            page: () => const onboarding.OnboardingPage()),
        GetPage(name: AppRoutes.login, page: () => const auth.LoginPage()),
        GetPage(
            name: AppRoutes.register, page: () => const auth.RegisterPage()),
        GetPage(name: AppRoutes.home, page: () => const home.HomePage()),
        GetPage(
            name: AppRoutes.courses, page: () => const courses.CoursesPage()),
        GetPage(
            name: AppRoutes.courseDetail,
            page: () => const courses.CourseDetailPage()),
        GetPage(name: AppRoutes.lesson, page: () => const lesson.LessonPage()),
        GetPage(
            name: AppRoutes.exercise, page: () => const lesson.ExercisePage()),
        GetPage(name: AppRoutes.review, page: () => const lesson.ReviewPage()),
        GetPage(
            name: AppRoutes.profile, page: () => const lesson.ProfilePage()),
        GetPage(
            name: AppRoutes.settings, page: () => const lesson.SettingsPage()),
        GetPage(
            name: AppRoutes.statistics,
            page: () => const lesson.StatisticsPage()),
        GetPage(name: AppRoutes.chat, page: () => const ChatPage()),
        GetPage(name: AppRoutes.dashboard, page: () => const DashboardPage()),
        GetPage(
            name: AppRoutes.contentGenerator,
            page: () => const ContentGeneratorPage()),
      ],
    );
  }
}
