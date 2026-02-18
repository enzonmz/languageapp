import 'package:get/get.dart';
import '../../../config/constants.dart';
import '../../../data/local/local_database.dart';

class OnboardingController extends GetxController {
  final selectedLanguage = ''.obs;
  final selectedLevel = ''.obs;
  final errorText = ''.obs;

  void completeOnboarding() {
    if (selectedLanguage.value.isEmpty) {
      errorText.value = 'Пожалуйста, выберите язык для изучения';
      return;
    }
    if (selectedLevel.value.isEmpty) {
      errorText.value = 'Пожалуйста, выберите ваш уровень';
      return;
    }

    errorText.value = '';

    // Сохраняем выбор пользователя
    LocalDatabase()
        .saveSetting(PrefKeys.selectedLanguage, selectedLanguage.value);
    LocalDatabase().saveSetting(PrefKeys.selectedLevel, selectedLevel.value);
    LocalDatabase().saveSetting(PrefKeys.onboardingCompleted, true);

    Get.offAllNamed('/login');
  }
}
