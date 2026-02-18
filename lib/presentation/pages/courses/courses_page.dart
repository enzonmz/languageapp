import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes.dart';
import '../../../data/local/course_data.dart';
import '../../../domain/models/course.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = CourseData.getAllCourses();

    return Scaffold(
      appBar: AppBar(title: const Text('Курсы')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.contentGenerator),
        label: const Text('Создать с AI'),
        icon: const Icon(Icons.auto_awesome),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // AI Generator Card
          Card(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.auto_awesome, color: Color(0xFF6C63FF)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Создайте курс с помощью AI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Grok AI сгенерирует уникальный курс по любой теме',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.contentGenerator),
                    icon: const Icon(Icons.add),
                    label: const Text('Создать курс'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // A1 Courses
          _buildSectionHeader('A1 - Начинающий'),
          const SizedBox(height: 12),
          ...courses
              .where((c) => c.level == 'A1')
              .map((course) => _CourseCard(course: course)),
          const SizedBox(height: 24),
          // A2 Courses
          _buildSectionHeader('A2 - Элементарный'),
          const SizedBox(height: 12),
          ...courses
              .where((c) => c.level == 'A2')
              .map((course) => _CourseCard(course: course)),
          const SizedBox(height: 24),
          // B1 Courses
          _buildSectionHeader('B1 - Средний'),
          const SizedBox(height: 12),
          ...courses
              .where((c) => c.level == 'B1')
              .map((course) => _CourseCard(course: course)),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6C63FF),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.courseDetail, arguments: course.id),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(course.imageUrl, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          course.level,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF6C63FF),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(' ${course.rating}'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.book, size: 16, color: Colors.grey),
                  Text(' ${course.lessonsCount} уроков'),
                  const SizedBox(width: 16),
                  const Icon(Icons.translate, size: 16, color: Colors.grey),
                  Text(' ${course.wordsCount} слов'),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String courseId = Get.arguments as String? ?? 'a1_1';
    final course = CourseData.getAllCourses().firstWhere(
      (c) => c.id == courseId,
      orElse: () => CourseData.getAllCourses().first,
    );
    final lessons = CourseData.getLessonsForCourse(courseId);

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Course Header
          Row(
            children: [
              Text(course.imageUrl, style: const TextStyle(fontSize: 64)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      '${course.level} • ${course.lessonsCount} уроков • ${course.wordsCount} слов',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' ${course.rating}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            course.description,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(
                AppRoutes.lesson,
                arguments: {'courseId': courseId, 'lessonNumber': 1},
              ),
              child: const Text('Начать обучение'),
            ),
          ),
          const SizedBox(height: 24),
          Text('Уроки (${lessons.length})',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          // Show first 20 lessons with pagination
          ...lessons
              .take(20)
              .map((lesson) => _buildLessonTile(context, lesson)),
          if (lessons.length > 20) ...[
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  // Show all lessons in a dialog or navigate to full list
                  _showAllLessonsDialog(context, lessons, courseId);
                },
                child: const Text('Показать все уроки'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLessonTile(BuildContext context, dynamic lesson) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              lesson.isCompleted ? const Color(0xFF00C897) : Colors.grey[300],
          child: lesson.isCompleted
              ? const Icon(Icons.check, color: Colors.white)
              : Text('${lesson.order}'),
        ),
        title: Text(lesson.title),
        subtitle: Text('${lesson.wordsCount} слов'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Get.toNamed(
          AppRoutes.lesson,
          arguments: {
            'courseId': lesson.courseId,
            'lessonNumber': lesson.order
          },
        ),
      ),
    );
  }

  void _showAllLessonsDialog(
      BuildContext context, List<dynamic> lessons, String courseId) {
    Get.dialog(
      AlertDialog(
        title: Text('Все уроки (${lessons.length})'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: lesson.isCompleted
                      ? const Color(0xFF00C897)
                      : Colors.grey[300],
                  child: lesson.isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : Text('${lesson.order}',
                          style: const TextStyle(fontSize: 14)),
                ),
                title: Text(lesson.title),
                subtitle: Text('${lesson.wordsCount} слов'),
                onTap: () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.lesson,
                    arguments: {
                      'courseId': courseId,
                      'lessonNumber': lesson.order
                    },
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}
