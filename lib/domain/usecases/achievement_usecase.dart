class AchievementUseCase {
  Future<List<Map<String, dynamic>>> getAchievements(String userId) async {
    return [
      {
        'id': 'streak_7',
        'name': '7 дней подряд',
        'icon': '🔥',
        'unlocked': false
      },
      {'id': 'words_100', 'name': '100 слов', 'icon': '📚', 'unlocked': false},
      {
        'id': 'lessons_10',
        'name': '10 уроков',
        'icon': '📖',
        'unlocked': false
      },
    ];
  }

  Future<void> checkAndUnlock(String userId, String achievementId) async {
    print('Achievement unlocked: $achievementId for user $userId');
  }
}
