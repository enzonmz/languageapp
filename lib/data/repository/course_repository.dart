import '../local/local_database.dart';
import '../remote/api_service.dart';
import '../../domain/models/course.dart';

class CourseRepository {
  CourseRepository({
    LocalDatabase? localDatabase,
    ApiService? apiService,
  })  : _localDatabase = localDatabase ?? LocalDatabase(),
        _apiService = apiService ?? ApiService();
  final LocalDatabase _localDatabase;
  final ApiService _apiService;

  Future<List<Course>> getCourses(String language) async {
    // Mock data for demo
    return [
      Course(
        language: 'en',
        level: 'A1',
        title: 'Английский для начинающих',
        description: 'Базовый курс английского языка для начинающих',
        lessonsCount: 10,
        wordsCount: 100,
        rating: 4.8,
      ),
      Course(
        language: 'en',
        level: 'A2',
        title: 'Английский - Elementary',
        description: 'Продвинутый начальный уровень',
        lessonsCount: 15,
        wordsCount: 150,
        rating: 4.6,
      ),
      Course(
        language: 'en',
        level: 'B1',
        title: 'Английский - Intermediate',
        description: 'Средний уровень владения',
        lessonsCount: 20,
        wordsCount: 200,
        rating: 4.7,
      ),
    ];
  }

  Future<List<CourseSection>> getSections(String courseId) async {
    // Mock data
    return [
      CourseSection(courseId: courseId, title: 'Приветствия', order: 1),
      CourseSection(courseId: courseId, title: 'Числа', order: 2),
      CourseSection(courseId: courseId, title: 'Еда', order: 3),
    ];
  }
}
