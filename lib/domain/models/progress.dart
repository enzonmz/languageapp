import 'package:uuid/uuid.dart';

class UserProgress {
  UserProgress({
    String? id,
    required this.userId,
    required this.lessonId,
    required this.wordId,
    this.progress = 0.0,
    this.isCompleted = false,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
    DateTime? startedAt,
    this.completedAt,
    DateTime? nextReviewAt,
    this.easeFactor = 250,
    this.interval = 0,
    this.repetitions = 0,
  })  : id = id ?? const Uuid().v4(),
        startedAt = startedAt ?? DateTime.now(),
        nextReviewAt = nextReviewAt ?? DateTime.now();

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as String,
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      wordId: json['wordId'] as String,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      incorrectAnswers: json['incorrectAnswers'] as int? ?? 0,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      nextReviewAt: DateTime.parse(json['nextReviewAt'] as String),
      easeFactor: json['easeFactor'] as int? ?? 250,
      interval: json['interval'] as int? ?? 0,
      repetitions: json['repetitions'] as int? ?? 0,
    );
  }
  final String id;
  final String userId;
  final String lessonId;
  final String wordId;
  final double progress;
  final bool isCompleted;
  final int correctAnswers;
  final int incorrectAnswers;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime nextReviewAt;
  final int easeFactor;
  final int interval;
  final int repetitions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'lessonId': lessonId,
      'wordId': wordId,
      'progress': progress,
      'isCompleted': isCompleted,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'nextReviewAt': nextReviewAt.toIso8601String(),
      'easeFactor': easeFactor,
      'interval': interval,
      'repetitions': repetitions,
    };
  }

  double get accuracy {
    final total = correctAnswers + incorrectAnswers;
    if (total == 0) return 0.0;
    return correctAnswers / total;
  }
}

class DailyStatistics {
  DailyStatistics({
    String? id,
    required this.userId,
    DateTime? date,
    this.lessonsCompleted = 0,
    this.wordsLearned = 0,
    this.wordsReviewed = 0,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
    this.timeSpentSeconds = 0,
    this.newWordsCount = 0,
  })  : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now();

  factory DailyStatistics.fromJson(Map<String, dynamic> json) {
    return DailyStatistics(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      lessonsCompleted: json['lessonsCompleted'] as int? ?? 0,
      wordsLearned: json['wordsLearned'] as int? ?? 0,
      wordsReviewed: json['wordsReviewed'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      incorrectAnswers: json['incorrectAnswers'] as int? ?? 0,
      timeSpentSeconds: json['timeSpentSeconds'] as int? ?? 0,
      newWordsCount: json['newWordsCount'] as int? ?? 0,
    );
  }
  final String id;
  final String userId;
  final DateTime date;
  final int lessonsCompleted;
  final int wordsLearned;
  final int wordsReviewed;
  final int correctAnswers;
  final int incorrectAnswers;
  final int timeSpentSeconds;
  final int newWordsCount;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'lessonsCompleted': lessonsCompleted,
      'wordsLearned': wordsLearned,
      'wordsReviewed': wordsReviewed,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'timeSpentSeconds': timeSpentSeconds,
      'newWordsCount': newWordsCount,
    };
  }

  double get accuracy {
    final total = correctAnswers + incorrectAnswers;
    if (total == 0) return 0.0;
    return correctAnswers / total;
  }
}

class Achievement {
  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.iconUrl = '',
    required this.type,
    required this.requiredValue,
    this.currentValue = 0,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String? ?? '',
      type: json['type'] as String,
      requiredValue: json['requiredValue'] as int,
      currentValue: json['currentValue'] as int? ?? 0,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
    );
  }
  final String id;
  final String title;
  final String description;
  final String iconUrl;
  final String type;
  final int requiredValue;
  final int currentValue;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'iconUrl': iconUrl,
      'type': type,
      'requiredValue': requiredValue,
      'currentValue': currentValue,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  double get progress {
    if (requiredValue == 0) return 0.0;
    return (currentValue / requiredValue).clamp(0.0, 1.0);
  }
}
