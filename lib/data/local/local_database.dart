import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  Box? _userBox;
  Box? _progressBox;
  Box? _wordsBox;
  Box? _settingsBox;

  bool get isInitialized => _settingsBox != null;

  Future<void> init() async {
    if (isInitialized) return;

    await Hive.initFlutter();

    _userBox = await Hive.openBox('user');
    _progressBox = await Hive.openBox('progress');
    _wordsBox = await Hive.openBox('words');
    _settingsBox = await Hive.openBox('settings');
  }

  // User operations
  dynamic getUser(String userId) {
    return _userBox?.get(userId);
  }

  List<String> getAllUserKeys() {
    return _userBox?.keys.map((e) => e.toString()).toList() ?? [];
  }

  Future<void> saveUser(String userId, Map<String, dynamic> userData) async {
    await _userBox?.put(userId, userData);
  }

  Future<void> deleteUser(String userId) async {
    await _userBox?.delete(userId);
  }

  // Progress operations
  List<dynamic> getUserProgress(String userId) {
    return _progressBox?.get(userId, defaultValue: []) ?? [];
  }

  Future<void> saveUserProgress(String userId, List<dynamic> progress) async {
    await _progressBox?.put(userId, progress);
  }

  // Daily statistics operations
  List<dynamic> getDailyStats(String userId) {
    return _progressBox?.get('daily_stats_$userId', defaultValue: []) ?? [];
  }

  Future<void> saveDailyStats(String userId, List<dynamic> stats) async {
    await _progressBox?.put('daily_stats_$userId', stats);
  }

  // Achievements operations
  List<dynamic> getAchievements(String userId) {
    return _progressBox?.get('achievements_$userId', defaultValue: []) ?? [];
  }

  Future<void> saveAchievements(
      String userId, List<dynamic> achievements) async {
    await _progressBox?.put('achievements_$userId', achievements);
  }

  // Words operations
  List<dynamic> getWordsForReview(String userId) {
    final words = _wordsBox?.get(userId, defaultValue: []) ?? [];
    final now = DateTime.now();
    return words
        .where(
          (word) =>
              word['nextReviewAt'] != null &&
              DateTime.parse(word['nextReviewAt']).isBefore(now),
        )
        .toList();
  }

  Future<void> saveWord(String userId, Map<String, dynamic> wordData) async {
    final words = (_wordsBox?.get(userId, defaultValue: []) as List?) ?? [];
    final existingIndex = words.indexWhere((w) => w['id'] == wordData['id']);
    if (existingIndex >= 0) {
      words[existingIndex] = wordData;
    } else {
      words.add(wordData);
    }
    await _wordsBox?.put(userId, words);
  }

  // Settings operations
  dynamic getSetting(String key) {
    return _settingsBox?.get(key);
  }

  Future<void> saveSetting(String key, dynamic value) async {
    if (value == null) {
      await _settingsBox?.delete(key);
    } else {
      await _settingsBox?.put(key, value);
    }
  }

  Future<void> clearAllData() async {
    await _userBox?.clear();
    await _progressBox?.clear();
    await _wordsBox?.clear();
    await _settingsBox?.clear();
  }
}
