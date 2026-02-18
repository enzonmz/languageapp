import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой прогресс'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refresh(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStreakCard(context),
              const SizedBox(height: 16),
              _buildXPProgress(context),
              const SizedBox(height: 24),
              _buildDailyStats(context),
              const SizedBox(height: 24),
              _buildWeeklyProgress(context),
              const SizedBox(height: 24),
              _buildOverallStats(context),
              const SizedBox(height: 24),
              _buildAchievements(context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStreakCard(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department,
                  color: Colors.white, size: 40),
              const SizedBox(width: 8),
              Text(
                '${controller.currentStreak}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'дней подряд',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${controller.totalXP} XP заработано',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPProgress(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final level = (controller.totalXP.value / 100).floor() + 1;
    final currentXP = controller.totalXP.value % 100;
    final progress = currentXP / 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Уровень',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Уровень $level',
                    style: const TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Color(0xFF6C63FF)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$currentXP / 100 XP до следующего уровня',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyStats(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сегодня',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.translate,
                value: '${controller.todayWords.value}',
                label: 'Слов',
                color: const Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.menu_book,
                value: '${controller.todayLessons.value}',
                label: 'Уроков',
                color: const Color(0xFF00C897),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.analytics,
                value: '${controller.todayAccuracy.value.toInt()}%',
                label: 'Точность',
                color: const Color(0xFFFFB347),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyProgress(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Эта неделя',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']
                      .map((day) => Text(
                            day,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final dayStats = controller.weeklyStats.length > index
                        ? controller.weeklyStats[index]
                        : null;
                    final hasActivity = dayStats != null &&
                        (dayStats.wordsLearned > 0 ||
                            dayStats.lessonsCompleted > 0);

                    return Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: hasActivity
                            ? const Color(0xFF6C63FF)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: hasActivity
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    );
                  }),
                ),
                const SizedBox(height: 12),
                Text(
                  '${controller.weeklyStats.fold(0, (sum, s) => sum + s.wordsLearned)} слов на этой неделе',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallStats(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Всего',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildOverallRow(
                  context,
                  icon: Icons.translate,
                  label: 'Выучено слов',
                  value: '${controller.wordsLearned.value}',
                  color: const Color(0xFF6C63FF),
                ),
                const Divider(),
                _buildOverallRow(
                  context,
                  icon: Icons.menu_book,
                  label: 'Пройдено уроков',
                  value: '${controller.lessonsCompleted.value}',
                  color: const Color(0xFF00C897),
                ),
                const Divider(),
                _buildOverallRow(
                  context,
                  icon: Icons.analytics,
                  label: 'Средняя точность',
                  value: '${controller.accuracy.value.toInt()}%',
                  color: const Color(0xFFFFB347),
                ),
                const Divider(),
                _buildOverallRow(
                  context,
                  icon: Icons.stars,
                  label: 'Всего XP',
                  value: '${controller.totalXP.value}',
                  color: const Color(0xFFFF6B6B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Достижения',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Все'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: controller.achievements.take(4).map((achievement) {
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: achievement.isUnlocked
                        ? const Color(0xFFFFB347).withOpacity(0.2)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    achievement.isUnlocked
                        ? Icons.emoji_events
                        : Icons.lock_outline,
                    color: achievement.isUnlocked
                        ? const Color(0xFFFFB347)
                        : Colors.grey,
                    size: 24,
                  ),
                ),
                title: Text(
                  achievement.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: achievement.isUnlocked ? Colors.black : Colors.grey,
                  ),
                ),
                subtitle: Text(achievement.description),
                trailing: achievement.isUnlocked
                    ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF00C897),
                      )
                    : SizedBox(
                        width: 60,
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: achievement.progress,
                              minHeight: 4,
                              backgroundColor: Colors.grey[200],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${achievement.currentValue}/${achievement.requiredValue}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Быстрые действия',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.lesson),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Урок'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.chat),
                icon: const Icon(Icons.chat),
                label: const Text('Чат'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.courses),
            icon: const Icon(Icons.book),
            label: const Text('Курсы'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
