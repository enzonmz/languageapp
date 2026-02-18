import 'package:get/get.dart';
import '../../../config/constants.dart';
import '../../../data/local/local_database.dart';
import '../../../domain/models/progress.dart';

class DashboardController extends GetxController {
  final LocalDatabase db = LocalDatabase();

  // Observable stats
  final wordsLearned = 0.obs;
  final lessonsCompleted = 0.obs;
  final currentStreak = 0.obs;
  final accuracy = 0.0.obs;
  final totalXP = 0.obs;
  final todayWords = 0.obs;
  final todayLessons = 0.obs;
  final todayAccuracy = 0.0.obs;

  // Weekly progress
  final weeklyStats = <DailyStatistics>[].obs;

  // Achievements
  final achievements = <Achievement>[].obs;

  // Loading state
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    isLoading.value = true;

    try {
      final userId = db.getSetting(PrefKeys.userId) as String?;
      if (userId == null) {
        isLoading.value = false;
        return;
      }

      // Load basic stats
      wordsLearned.value = await _getTotalWordsLearned(userId);
      lessonsCompleted.value = await _getTotalLessonsCompleted(userId);
      currentStreak.value = await _calculateStreak(userId);
      totalXP.value = await _calculateTotalXP(userId);

      // Load today's stats
      final todayStat = await _getTodayStats(userId);
      todayWords.value = todayStat.wordsLearned;
      todayLessons.value = todayStat.lessonsCompleted;
      todayAccuracy.value = todayStat.accuracy * 100;

      // Calculate overall accuracy
      final allStats = await _getAllDailyStats(userId);
      if (allStats.isNotEmpty) {
        int totalCorrect = 0;
        int totalIncorrect = 0;
        for (final stat in allStats) {
          totalCorrect += stat.correctAnswers;
          totalIncorrect += stat.incorrectAnswers;
        }
        accuracy.value = totalCorrect + totalIncorrect > 0
            ? (totalCorrect / (totalCorrect + totalIncorrect)) * 100
            : 0.0;
      }

      // Load weekly stats
      weeklyStats.value = await _getWeeklyStats(userId);

      // Load achievements
      achievements.value = await _loadAchievements(userId);
    } catch (e) {
      print('DEBUG: Dashboard load error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<int> _getTotalWordsLearned(String userId) async {
    final stats = await _getAllDailyStats(userId);
    int total = 0;
    for (final stat in stats) {
      total += stat.wordsLearned;
    }
    return total;
  }

  Future<int> _getTotalLessonsCompleted(String userId) async {
    final stats = await _getAllDailyStats(userId);
    int total = 0;
    for (final stat in stats) {
      total += stat.lessonsCompleted;
    }
    return total;
  }

  Future<int> _calculateStreak(String userId) async {
    final stats = await _getAllDailyStats(userId);
    if (stats.isEmpty) return 0;

    // Sort by date descending
    stats.sort((a, b) => b.date.compareTo(a.date));

    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (final stat in stats) {
      final statDate = DateTime(stat.date.year, stat.date.month, stat.date.day);
      final expectedDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);

      if (statDate == expectedDate && stat.lessonsCompleted > 0) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (statDate == expectedDate.subtract(const Duration(days: 1)) &&
          stat.lessonsCompleted > 0) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  Future<int> _calculateTotalXP(String userId) async {
    // XP calculation: 10 XP per lesson, 1 XP per word learned
    final words = await _getTotalWordsLearned(userId);
    final lessons = await _getTotalLessonsCompleted(userId);
    return (lessons * 10) + (words * 1);
  }

  Future<DailyStatistics> _getTodayStats(String userId) async {
    final today = DateTime.now();
    final todayStr = _formatDate(today);

    final stats = await _getAllDailyStats(userId);
    return stats.firstWhere(
      (s) => _formatDate(s.date) == todayStr,
      orElse: () => DailyStatistics(userId: userId),
    );
  }

  Future<List<DailyStatistics>> _getAllDailyStats(String userId) async {
    final statsData = db.getDailyStats(userId);
    if (statsData.isEmpty) return [];

    return statsData
        .map((e) => DailyStatistics.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<DailyStatistics>> _getWeeklyStats(String userId) async {
    final allStats = await _getAllDailyStats(userId);
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));

    return allStats.where((s) => s.date.isAfter(weekAgo)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Future<List<Achievement>> _loadAchievements(String userId) async {
    final achievementsData = db.getAchievements(userId);
    if (achievementsData.isNotEmpty) {
      return achievementsData
          .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Create default achievements
    return _createDefaultAchievements();
  }

  List<Achievement> _createDefaultAchievements() {
    final totalWords = wordsLearned.value;
    final totalLessons = lessonsCompleted.value;
    final streak = currentStreak.value;

    return [
      Achievement(
        id: 'first_word',
        title: 'Первый шаг',
        description: 'Выучите первое слово',
        type: 'words',
        requiredValue: 1,
        currentValue: totalWords >= 1 ? 1 : 0,
        isUnlocked: totalWords >= 1,
      ),
      Achievement(
        id: '10_words',
        title: 'Начинающий',
        description: 'Выучите 10 слов',
        type: 'words',
        requiredValue: 10,
        currentValue: totalWords >= 10 ? 10 : totalWords,
        isUnlocked: totalWords >= 10,
      ),
      Achievement(
        id: '50_words',
        title: 'Продвинутый',
        description: 'Выучите 50 слов',
        type: 'words',
        requiredValue: 50,
        currentValue: totalWords >= 50 ? 50 : totalWords,
        isUnlocked: totalWords >= 50,
      ),
      Achievement(
        id: 'first_lesson',
        title: 'Первый урок',
        description: 'Пройдите первый урок',
        type: 'lessons',
        requiredValue: 1,
        currentValue: totalLessons >= 1 ? 1 : 0,
        isUnlocked: totalLessons >= 1,
      ),
      Achievement(
        id: '10_lessons',
        title: 'Трудяга',
        description: 'Пройдите 10 уроков',
        type: 'lessons',
        requiredValue: 10,
        currentValue: totalLessons >= 10 ? 10 : totalLessons,
        isUnlocked: totalLessons >= 10,
      ),
      Achievement(
        id: '7_day_streak',
        title: 'Непрерывность',
        description: 'Занимайтесь 7 дней подряд',
        type: 'streak',
        requiredValue: 7,
        currentValue: streak >= 7 ? 7 : streak,
        isUnlocked: streak >= 7,
      ),
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Update progress when lesson is completed
  Future<void> recordLessonComplete(String userId, int wordsInLesson) async {
    final today = _formatDate(DateTime.now());
    final stats = await _getAllDailyStats(userId);

    final existingIndex = stats.indexWhere((s) => _formatDate(s.date) == today);
    final stat = existingIndex >= 0
        ? stats[existingIndex]
        : DailyStatistics(userId: userId);

    final updatedStat = DailyStatistics(
      id: stat.id,
      userId: userId,
      date: stat.date,
      lessonsCompleted: stat.lessonsCompleted + 1,
      wordsLearned: stat.wordsLearned + wordsInLesson,
      wordsReviewed: stat.wordsReviewed,
      correctAnswers: stat.correctAnswers,
      incorrectAnswers: stat.incorrectAnswers,
      timeSpentSeconds: stat.timeSpentSeconds,
      newWordsCount: stat.newWordsCount + wordsInLesson,
    );

    if (existingIndex >= 0) {
      stats[existingIndex] = updatedStat;
    } else {
      stats.add(updatedStat);
    }

    await db.saveDailyStats(userId, stats.map((e) => e.toJson()).toList());

    // Reload data
    await loadDashboardData();
  }

  // Update progress when exercise is completed
  Future<void> recordExerciseResult(String userId, bool isCorrect) async {
    final today = _formatDate(DateTime.now());
    final stats = await _getAllDailyStats(userId);

    final existingIndex = stats.indexWhere((s) => _formatDate(s.date) == today);
    final stat = existingIndex >= 0
        ? stats[existingIndex]
        : DailyStatistics(userId: userId);

    final updatedStat = DailyStatistics(
      id: stat.id,
      userId: userId,
      date: stat.date,
      lessonsCompleted: stat.lessonsCompleted,
      wordsLearned: stat.wordsLearned,
      wordsReviewed: stat.wordsReviewed + 1,
      correctAnswers: isCorrect ? stat.correctAnswers + 1 : stat.correctAnswers,
      incorrectAnswers:
          !isCorrect ? stat.incorrectAnswers + 1 : stat.incorrectAnswers,
      timeSpentSeconds: stat.timeSpentSeconds,
      newWordsCount: stat.newWordsCount,
    );

    if (existingIndex >= 0) {
      stats[existingIndex] = updatedStat;
    } else {
      stats.add(updatedStat);
    }

    await db.saveDailyStats(userId, stats.map((e) => e.toJson()).toList());

    // Reload data
    await loadDashboardData();
  }

  // Refresh data
  Future<void> refresh() async {
    await loadDashboardData();
  }
}
