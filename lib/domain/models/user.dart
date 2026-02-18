import 'package:uuid/uuid.dart';

class AppUser {
  AppUser({
    String? id,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.targetLanguage = 'en',
    this.level = 'A1',
    this.dailyGoalMinutes = 10,
    this.streak = 0,
    this.totalWordsLearned = 0,
    this.totalLessonsCompleted = 0,
    this.accuracy = 0.0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      targetLanguage: json['targetLanguage'] as String? ?? 'en',
      level: json['level'] as String? ?? 'A1',
      dailyGoalMinutes: json['dailyGoalMinutes'] as int? ?? 10,
      streak: json['streak'] as int? ?? 0,
      totalWordsLearned: json['totalWordsLearned'] as int? ?? 0,
      totalLessonsCompleted: json['totalLessonsCompleted'] as int? ?? 0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;
  final String targetLanguage;
  final String level;
  final int dailyGoalMinutes;
  final int streak;
  final int totalWordsLearned;
  final int totalLessonsCompleted;
  final double accuracy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'targetLanguage': targetLanguage,
      'level': level,
      'dailyGoalMinutes': dailyGoalMinutes,
      'streak': streak,
      'totalWordsLearned': totalWordsLearned,
      'totalLessonsCompleted': totalLessonsCompleted,
      'accuracy': accuracy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    String? targetLanguage,
    String? level,
    int? dailyGoalMinutes,
    int? streak,
    int? totalWordsLearned,
    int? totalLessonsCompleted,
    double? accuracy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      level: level ?? this.level,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      streak: streak ?? this.streak,
      totalWordsLearned: totalWordsLearned ?? this.totalWordsLearned,
      totalLessonsCompleted:
          totalLessonsCompleted ?? this.totalLessonsCompleted,
      accuracy: accuracy ?? this.accuracy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
