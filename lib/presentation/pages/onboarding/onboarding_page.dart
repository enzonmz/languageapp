import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';
import '../../../config/constants.dart';
import '../../../data/local/local_database.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.school, size: 120, color: Color(0xFF6C63FF)),
            const SizedBox(height: 32),
            Text(
              'Добро пожаловать!',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Изучай новые языки с помощью коротких уроков',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            _buildLanguageSelector(context, controller),
            const SizedBox(height: 24),
            _buildLevelSelector(context, controller),
            const SizedBox(height: 16),
            Obx(() => controller.errorText.value.isNotEmpty
                ? Text(
                    controller.errorText.value,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  )
                : const SizedBox.shrink()),
            const Spacer(),
            _buildStartButton(context, controller),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
      BuildContext context, OnboardingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Выберите язык для изучения',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: SupportedLanguages.all.map((lang) {
            return Obx(() => ChoiceChip(
                  selected: controller.selectedLanguage.value == lang,
                  label: Text(SupportedLanguages.getName(lang)),
                  selectedColor: const Color(0xFF6C63FF),
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: controller.selectedLanguage.value == lang
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  onSelected: (selected) {
                    controller.selectedLanguage.value = lang;
                  },
                ));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLevelSelector(
      BuildContext context, OnboardingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ваш уровень', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: LanguageLevel.all.map((level) {
            return Obx(() => ChoiceChip(
                  selected: controller.selectedLevel.value == level,
                  label: Text('${level} - ${LanguageLevel.getName(level)}'),
                  selectedColor: const Color(0xFF6C63FF),
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: controller.selectedLevel.value == level
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  onSelected: (selected) {
                    controller.selectedLevel.value = level;
                  },
                ));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStartButton(
      BuildContext context, OnboardingController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.completeOnboarding(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Начать', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
