import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';
import '../../../config/constants.dart';
import '../../../data/remote/content_generator_service.dart';
import '../../../data/local/local_database.dart';

class ContentGeneratorPage extends StatefulWidget {
  const ContentGeneratorPage({super.key});

  @override
  State<ContentGeneratorPage> createState() => _ContentGeneratorPageState();
}

class _ContentGeneratorPageState extends State<ContentGeneratorPage> {
  final contentService = ContentGeneratorService();

  int selectedTopicIndex = 0;
  String selectedLevel = 'A1';
  bool isGenerating = false;
  String statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать курс с AI'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.auto_awesome,
                        size: 48, color: Color(0xFF6C63FF)),
                    const SizedBox(height: 12),
                    const Text(
                      'Grok AI сгенерирует курс',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Выберите тему и уровень, AI создаст уроки, слова и упражнения',
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Level selector
            const Text('Уровень',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ContentGeneratorService.getLevels().length,
                itemBuilder: (context, index) {
                  final level = ContentGeneratorService.getLevels()[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: selectedLevel == level,
                      label: Text(level),
                      selectedColor: const Color(0xFF6C63FF).withOpacity(0.2),
                      checkmarkColor: const Color(0xFF6C63FF),
                      onSelected: (selected) {
                        setState(() {
                          selectedLevel = level;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Topic selector
            const Text('Тема',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: ContentGeneratorService.topics.length,
                itemBuilder: (context, index) {
                  final topic = ContentGeneratorService.topics[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: selectedTopicIndex == index
                            ? const Color(0xFF6C63FF)
                            : Colors.grey[300],
                        child: Text('${index + 1}',
                            style: TextStyle(
                              color: selectedTopicIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                      title: Text(topic),
                      selected: selectedTopicIndex == index,
                      selectedTileColor:
                          const Color(0xFF6C63FF).withOpacity(0.1),
                      onTap: () {
                        setState(() {
                          selectedTopicIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Generate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isGenerating ? null : () => _generateCourse(),
                icon: isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.auto_awesome),
                label:
                    Text(isGenerating ? statusMessage : 'Сгенерировать курс'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick topics grid
            const Text('Или выберите популярную тему',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickTopic('Еда', Colors.orange),
                _buildQuickTopic('Путешествия', Colors.blue),
                _buildQuickTopic('Работа', Colors.green),
                _buildQuickTopic('Семья', Colors.pink),
                _buildQuickTopic('Дом', Colors.brown),
                _buildQuickTopic('Технологии', Colors.indigo),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTopic(String topic, Color color) {
    return ActionChip(
      avatar: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(Icons.tag, size: 16, color: color),
      ),
      label: Text(topic),
      onPressed: () {
        final index = ContentGeneratorService.topics
            .indexWhere((t) => t.toLowerCase().contains(topic.toLowerCase()));
        if (index >= 0) {
          setState(() {
            selectedTopicIndex = index;
          });
        }
      },
    );
  }

  Future<void> _generateCourse() async {
    setState(() {
      isGenerating = true;
      statusMessage = 'Создаем курс...';
    });

    try {
      final topic = ContentGeneratorService.topics[selectedTopicIndex];

      setState(() => statusMessage = 'Генерируем урок 1...');
      final lesson1 = await contentService.generateLesson(
          'custom_${DateTime.now().millisecondsSinceEpoch}', topic, 1);
      await contentService.saveGeneratedLesson(lesson1);

      setState(() => statusMessage = 'Генерируем урок 2...');
      final lesson2 =
          await contentService.generateLesson(lesson1.courseId, topic, 2);
      await contentService.saveGeneratedLesson(lesson2);

      setState(() => statusMessage = 'Генерируем урок 3...');
      final lesson3 =
          await contentService.generateLesson(lesson1.courseId, topic, 3);
      await contentService.saveGeneratedLesson(lesson3);

      setState(() => statusMessage = 'Генерируем урок 4...');
      final lesson4 =
          await contentService.generateLesson(lesson1.courseId, topic, 4);
      await contentService.saveGeneratedLesson(lesson4);

      setState(() => statusMessage = 'Генерируем урок 5...');
      final lesson5 =
          await contentService.generateLesson(lesson1.courseId, topic, 5);
      await contentService.saveGeneratedLesson(lesson5);

      Get.snackbar(
        'Курс создан!',
        'Курс "$topic" готов к изучению',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF00C897).withOpacity(0.9),
        colorText: Colors.white,
      );

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(AppRoutes.home);
      });
    } catch (e) {
      Get.snackbar(
        'Ошибка',
        'Не удалось создать курс: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isGenerating = false;
        statusMessage = '';
      });
    }
  }
}
