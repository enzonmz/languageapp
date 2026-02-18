import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изучение языков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDailyGoal(context),
          const SizedBox(height: 24),
          _buildSectionHeader('Продолжить обучение'),
          const SizedBox(height: 12),
          _buildCurrentLesson(),
          const SizedBox(height: 24),
          _buildSectionHeader('Курсы'),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCourseCard(context, 'Английский A1', 'A1', 10, 4.8),
                const SizedBox(width: 12),
                _buildCourseCard(context, 'Английский A2', 'A2', 15, 4.6),
                const SizedBox(width: 12),
                _buildCourseCard(context, 'Английский B1', 'B1', 20, 4.7),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Прогресс'),
          const SizedBox(height: 12),
          _buildProgressCard(context),
          const SizedBox(height: 24),
          _buildSectionHeader('Чат-бот'),
          const SizedBox(height: 12),
          _buildReviewCard(context),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(AppRoutes.home);
              break;
            case 1:
              Get.toNamed(AppRoutes.courses);
              break;
            case 2:
              Get.toNamed(AppRoutes.chat);
              break;
            case 3:
              Get.toNamed(AppRoutes.profile);
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Курсы'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Чат-бот'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  Widget _buildDailyGoal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ваша цель на сегодня',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                '10 минут',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.3,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: const Text('Все')),
      ],
    );
  }

  Widget _buildCurrentLesson() {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.lesson),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.play_arrow, color: Color(0xFF6C63FF)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Приветствия',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Урок 1 из 10',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                          value: 0.1, minHeight: 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    String title,
    String level,
    int lessons,
    double rating,
  ) {
    return SizedBox(
      width: 140,
      child: Card(
        child: InkWell(
          onTap: () => Get.toNamed(AppRoutes.courseDetail),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.flag, size: 32, color: Color(0xFF6C63FF)),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                ),
                Text(level, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.book, size: 14),
                    Text(
                      ' $lessons уроков',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context) {
    return Card(
      color: const Color(0xFF6C63FF).withOpacity(0.1),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.chat),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.chat, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Чат-бот для практики',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Практикуйте язык с AI',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Card(
      color: const Color(0xFFFF6B6B).withOpacity(0.1),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.dashboard),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bar_chart, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Мой прогресс',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Статистика и достижения',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
