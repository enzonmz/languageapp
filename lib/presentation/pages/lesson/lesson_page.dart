import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';
import '../../../config/constants.dart';
import '../../../data/local/course_data.dart';
import '../../../data/local/local_database.dart';
import '../../../domain/models/lesson.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAvatar(),
            const SizedBox(height: 16),
            _buildUserInfo(context),
            const SizedBox(height: 32),
            _buildStatsSection(context),
            const SizedBox(height: 24),
            _buildMenuSection(context),
            const SizedBox(height: 32),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 60,
        backgroundColor: Color(0xFF6C63FF),
        child: Icon(Icons.person, size: 60, color: Colors.white),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final userId = LocalDatabase().getSetting(PrefKeys.userId) as String?;
    String userName = 'Гость';
    String userEmail = '';

    if (userId != null) {
      final user = LocalDatabase().getUser(userId);
      if (user != null) {
        userName = user['name'] ?? 'Гость';
        userEmail = user['email'] ?? '';
      }
    }

    return Column(
      children: [
        Text(
          userName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          userEmail,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final userId = LocalDatabase().getSetting(PrefKeys.userId) as String?;
    final stats = userId != null ? LocalDatabase().getDailyStats(userId) : [];
    final todayStats = stats.isNotEmpty ? stats.last : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ваша статистика',
                style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.dashboard),
              child: const Text('Подробнее'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final stat = _getStat(index, todayStats, userId);
            return _buildStatCard(context, stat);
          },
        ),
      ],
    );
  }

  Map<String, dynamic> _getStat(
      int index, dynamic? todayStats, String? userId) {
    switch (index) {
      case 0:
        return {
          'icon': Icons.translate,
          'label': 'Выучено слов',
          'value': '${todayStats?['wordsLearned'] ?? 0}',
          'color': const Color(0xFF6C63FF)
        };
      case 1:
        return {
          'icon': Icons.menu_book,
          'label': 'Уроков',
          'value': '${todayStats?['lessonsCompleted'] ?? 0}',
          'color': const Color(0xFF00C897)
        };
      case 2:
        return {
          'icon': Icons.local_fire_department,
          'label': 'Дней подряд',
          'value': '${LocalDatabase().getSetting(PrefKeys.streak) ?? 0}',
          'color': const Color(0xFFFF6B6B)
        };
      case 3:
        return {
          'icon': Icons.analytics,
          'label': 'Точность',
          'value': '${(todayStats?['accuracy'] ?? 0).toInt()}%',
          'color': const Color(0xFFFFB347)
        };
      default:
        return {
          'icon': Icons.help,
          'label': '-',
          'value': '0',
          'color': Colors.grey
        };
    }
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(stat['icon'] as IconData,
                size: 32, color: stat['color'] as Color),
            const SizedBox(height: 8),
            Text(
              stat['value'] as String,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              stat['label'] as String,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.bar_chart,
        'title': 'Мой прогресс',
        'route': AppRoutes.dashboard
      },
      {
        'icon': Icons.settings,
        'title': 'Настройки',
        'route': AppRoutes.settings
      },
      {'icon': Icons.help_outline, 'title': 'Помощь', 'route': ''},
      {'icon': Icons.info_outline, 'title': 'О приложении', 'route': ''},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Меню', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: menuItems.map((item) {
              return ListTile(
                leading: Icon(item['icon'] as IconData),
                title: Text(item['title'] as String),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  if (item['route'] as String != '') {
                    Get.toNamed(item['route'] as String);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[400],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: const Icon(Icons.logout),
        label: const Text('Выйти из аккаунта'),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Вы уверены, что хотите выйти из аккаунта?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await LocalDatabase().saveSetting(PrefKeys.userId, null);
              Get.offAllNamed(AppRoutes.splash);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}

// Страница урока с реальными данными
class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Читаем аргументы из GetX
    final arguments = Get.arguments as Map<String, dynamic>? ??
        {'courseId': 'a1_1', 'lessonNumber': 1};
    final String courseId = arguments['courseId'] as String? ?? 'a1_1';
    final int lessonNumber = arguments['lessonNumber'] as int? ?? 1;

    final lessons = CourseData.getLessonsForCourse(courseId);
    final lesson = lessons.length >= lessonNumber
        ? lessons[lessonNumber - 1]
        : lessons.first;
    final course = CourseData.getAllCourses().firstWhere(
      (c) => c.id == courseId,
      orElse: () => CourseData.getAllCourses().first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.close), onPressed: () => Get.back()),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
              value: lessonNumber / lessons.length, minHeight: 4),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title,
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 12)),
                    Text(lesson.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${lesson.wordsCount} слов',
                      style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lesson.words.length,
              itemBuilder: (context, index) {
                final word = lesson.words[index];
                return _buildWordCard(context, word.word, word.translation,
                    word.transcription ?? '', word.examples);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Save progress
                  final userId =
                      LocalDatabase().getSetting(PrefKeys.userId) as String?;
                  if (userId != null) {
                    _saveLessonProgress(
                        userId, courseId, lessonNumber, lesson.wordsCount);
                  }
                  // Navigate to exercise
                  Get.toNamed(AppRoutes.exercise, arguments: {
                    'courseId': courseId,
                    'lessonNumber': lessonNumber
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                    'Продолжить (${lesson.words.length}/${lesson.words.length})'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveLessonProgress(
      String userId, String courseId, int lessonNumber, int wordsCount) {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final stats = LocalDatabase().getDailyStats(userId);
    final existingIndex = stats.indexWhere((s) => s['date'] == today);

    if (existingIndex >= 0) {
      stats[existingIndex]['wordsLearned'] =
          (stats[existingIndex]['wordsLearned'] ?? 0) + wordsCount;
      stats[existingIndex]['lessonsCompleted'] =
          (stats[existingIndex]['lessonsCompleted'] ?? 0) + 1;
    } else {
      stats.add({
        'date': today,
        'wordsLearned': wordsCount,
        'lessonsCompleted': 1,
        'accuracy': 0,
        'xpEarned': wordsCount * 10,
      });
    }
    LocalDatabase().saveDailyStats(userId, stats);
  }

  Widget _buildWordCard(BuildContext context, String word, String translation,
      String transcription, List<String> examples) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(word,
                          style: Theme.of(context).textTheme.headlineSmall),
                      if (transcription.isNotEmpty)
                        Text(transcription,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey[600])),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            Text(translation,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: const Color(0xFF6C63FF))),
            if (examples.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              ...examples.take(2).map((example) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(example,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic)),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

// Страница упражнений
class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Читаем аргументы из GetX
    final arguments = Get.arguments as Map<String, dynamic>? ??
        {'courseId': 'a1_1', 'lessonNumber': 1};
    final String courseId = arguments['courseId'] as String? ?? 'a1_1';
    final int lessonNumber = arguments['lessonNumber'] as int? ?? 1;

    final lessons = CourseData.getLessonsForCourse(courseId);
    final lesson = lessons.length >= lessonNumber
        ? lessons[lessonNumber - 1]
        : lessons.first;
    final words = lesson.words;

    if (words.isEmpty) return _buildCompletedScreen(context);

    final currentWord = words[0];
    final options = [currentWord.translation]
      ..addAll(words.skip(1).take(3).map((w) => w.translation).toList())
      ..shuffle();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Упражнение'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(value: 0.5, minHeight: 4),
            const SizedBox(height: 24),
            Text('Урок $lessonNumber',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            Text('Как переводится?',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(currentWord.word,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6C63FF),
                    )),
            if (currentWord.transcription?.isNotEmpty ?? false)
              Text(currentWord.transcription!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16)),
            const SizedBox(height: 32),
            ...options.map((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _handleAnswer(
                          context,
                          option == currentWord.translation,
                          courseId,
                          lessonNumber),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Text(option, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _handleAnswer(
      BuildContext context, bool isCorrect, String courseId, int lessonNumber) {
    final userId = LocalDatabase().getSetting(PrefKeys.userId) as String?;
    if (userId != null) {
      _saveExerciseResult(userId, isCorrect);
    }

    if (isCorrect) {
      Get.snackbar('Правильно! 🎉', 'Отлично!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF00C897).withOpacity(0.95),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);

      // Navigate to next lesson or completion
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (lessonNumber < 50) {
          Get.toNamed(AppRoutes.lesson, arguments: {
            'courseId': courseId,
            'lessonNumber': lessonNumber + 1
          });
        } else {
          Get.offAllNamed(AppRoutes.home);
        }
      });
    } else {
      Get.snackbar('Неправильно', 'Попробуйте ещё раз',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.95),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    }
  }

  void _saveExerciseResult(String userId, bool isCorrect) {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final stats = LocalDatabase().getDailyStats(userId);
    final existingIndex = stats.indexWhere((s) => s['date'] == today);

    int correct = isCorrect ? 1 : 0;
    int total = 1;

    if (existingIndex >= 0) {
      stats[existingIndex]['correctAnswers'] =
          (stats[existingIndex]['correctAnswers'] ?? 0) + correct;
      stats[existingIndex]['totalAnswers'] =
          (stats[existingIndex]['totalAnswers'] ?? 0) + total;
      final newCorrect = stats[existingIndex]['correctAnswers'] as int;
      final newTotal = stats[existingIndex]['totalAnswers'] as int;
      stats[existingIndex]['accuracy'] =
          newTotal > 0 ? (newCorrect / newTotal * 100) : 0;
    } else {
      stats.add({
        'date': today,
        'wordsLearned': 0,
        'lessonsCompleted': 0,
        'correctAnswers': correct,
        'totalAnswers': total,
        'accuracy': isCorrect ? 100.0 : 0.0,
        'xpEarned': isCorrect ? 10 : 0,
      });
    }
    LocalDatabase().saveDailyStats(userId, stats);
  }

  Widget _buildCompletedScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Урок завершён')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Color(0xFFFFB347)),
            const SizedBox(height: 32),
            const Text('Урок завершён!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Отличная работа! 🎉',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 48),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.home),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('На главную', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Страница настроек
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Цель обучения'),
          DropdownButton<int>(
              value: 10,
              items: [5, 10, 15, 30]
                  .map((m) =>
                      DropdownMenuItem(value: m, child: Text('$m мин/день')))
                  .toList(),
              onChanged: (v) {}),
          const SizedBox(height: 16),
          const Text('Скорость озвучки'),
          Slider(value: 1.0, min: 0.5, max: 1.5, onChanged: (v) {}),
          SwitchListTile(
              value: true, onChanged: (v) {}, title: const Text('Уведомления')),
          SwitchListTile(
              value: false,
              onChanged: (v) {},
              title: const Text('Темная тема')),
        ],
      ),
    );
  }
}

// Страница статистики
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('За неделю',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildStatRow('Изучено слов', '35'),
          _buildStatRow('Пройдено уроков', '8'),
          _buildStatRow('Время обучения', '2ч 15м'),
          _buildStatRow('Средняя точность', '85%'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

// Заглушка для ReviewPage
class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Повторение')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.replay, size: 80, color: Color(0xFF00C897)),
            const SizedBox(height: 24),
            const Text('Функция повторения',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Перейдите в раздел "Мой прогресс"'),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.dashboard),
                  child: const Text('К прогрессу')),
            ),
          ],
        ),
      ),
    );
  }
}
