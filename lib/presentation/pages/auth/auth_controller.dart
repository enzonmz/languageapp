import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../config/routes.dart';
import '../../../config/constants.dart';
import '../../../data/local/local_database.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final isLoading = false.obs;
  final errorText = ''.obs;
  final currentUser = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  void loadCurrentUser() {
    final userId = LocalDatabase().getSetting(PrefKeys.userId);
    if (userId != null) {
      final user = LocalDatabase().getUser(userId);
      if (user != null) {
        currentUser.value = Map<String, dynamic>.from(user);
      }
    }
  }

  Future<void> login() async {
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      errorText.value = 'Заполните все поля';
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      errorText.value = 'Введите корректный email';
      return;
    }

    if (password.length < 6) {
      errorText.value = 'Пароль должен быть минимум 6 символов';
      return;
    }

    errorText.value = '';
    isLoading.value = true;

    // Увеличиваем задержку для стабилизации Hive
    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      // Принудительно обновляем данные Hive
      LocalDatabase().getAllUserKeys();

      // Ищем пользователя по email
      final allKeys = LocalDatabase().getAllUserKeys();
      print('DEBUG: Found ${allKeys.length} users in database');
      dynamic existingUser = null;
      String? foundUserId;

      for (final key in allKeys) {
        final user = LocalDatabase().getUser(key);
        print('DEBUG: Checking user $key: ${user?['email']}');
        if (user != null && user['email']?.toString().toLowerCase() == email) {
          existingUser = user;
          foundUserId = key;
          print('DEBUG: Found matching user: $foundUserId');
          break;
        }
      }

      if (existingUser != null && existingUser['password'] == password) {
        await LocalDatabase().saveSetting(PrefKeys.userId, foundUserId!);
        await LocalDatabase()
            .saveSetting(PrefKeys.authToken, const Uuid().v4());
        currentUser.value = Map<String, dynamic>.from(existingUser);
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.home);
      } else {
        errorText.value = 'Пользователь не найден или неверный пароль';
        isLoading.value = false;
      }
    } catch (e) {
      print('DEBUG: Login error: $e');
      errorText.value = 'Ошибка входа: $e';
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorText.value = 'Заполните все поля';
      return;
    }

    if (name.length < 2) {
      errorText.value = 'Имя должно быть минимум 2 символа';
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      errorText.value = 'Введите корректный email';
      return;
    }

    if (password.length < 6) {
      errorText.value = 'Пароль должен быть минимум 6 символов';
      return;
    }

    errorText.value = '';
    isLoading.value = true;

    await Future.delayed(
        const Duration(milliseconds: 500)); // Имитация загрузки

    try {
      // Проверяем, существует ли уже пользователь с таким email
      final allKeys = LocalDatabase().getAllUserKeys();
      for (final key in allKeys) {
        final user = LocalDatabase().getUser(key);
        if (user != null && user['email']?.toString().toLowerCase() == email) {
          errorText.value = 'Пользователь с таким email уже существует';
          isLoading.value = false;
          return;
        }
      }

      // Создаем уникальный ID пользователя
      final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      // Создаем нового пользователя
      await LocalDatabase().saveUser(userId, {
        'id': userId,
        'name': name,
        'email': email,
        'password': password,
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Ждем, чтобы данные сохранились
      await Future.delayed(const Duration(milliseconds: 500));

      // Проверяем, что пользователь сохранился
      final savedUser = LocalDatabase().getUser(userId);
      print('DEBUG: Registered user $userId: ${savedUser?['email']}');

      // Автоматически входим
      await LocalDatabase().saveSetting(PrefKeys.userId, userId);
      await LocalDatabase().saveSetting(PrefKeys.authToken, const Uuid().v4());

      currentUser.value = {
        'id': userId,
        'name': name,
        'email': email,
      };

      isLoading.value = false;
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorText.value = 'Ошибка регистрации: $e';
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await LocalDatabase().saveSetting(PrefKeys.userId, null);
    await LocalDatabase().saveSetting(PrefKeys.authToken, null);
    currentUser.clear();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    Get.offAllNamed(AppRoutes.login);
  }

  void clearError() {
    errorText.value = '';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
