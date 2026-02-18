import 'package:uuid/uuid.dart';
import 'word.dart';
import 'exercise.dart';

class Lesson {
  Lesson({
    String? id,
    required this.courseId,
    required this.sectionId,
    required this.title,
    this.description = '',
    this.topic = '',
    this.order = 0,
    this.wordsCount = 0,
    this.exercisesCount = 0,
    this.durationMinutes = 5,
    this.isCompleted = false,
    this.progress = 0.0,
    this.words = const [],
    this.exercises = const [],
    this.grammarRule,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      sectionId: json['sectionId'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      wordsCount: json['wordsCount'] as int? ?? 0,
      exercisesCount: json['exercisesCount'] as int? ?? 0,
      durationMinutes: json['durationMinutes'] as int? ?? 5,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      grammarRule: json['grammarRule'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  final String id;
  final String courseId;
  final String sectionId;
  final String title;
  final String description;
  final String topic;
  final int order;
  final int wordsCount;
  final int exercisesCount;
  final int durationMinutes;
  final bool isCompleted;
  final double progress;
  final List<Word> words;
  final List<Exercise> exercises;
  final String? grammarRule;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'sectionId': sectionId,
      'title': title,
      'description': description,
      'topic': topic,
      'order': order,
      'wordsCount': wordsCount,
      'exercisesCount': exercisesCount,
      'durationMinutes': durationMinutes,
      'isCompleted': isCompleted,
      'progress': progress,
      'words': words.map((e) => e.toJson()).toList(),
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'grammarRule': grammarRule,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Lesson copyWith({
    String? id,
    String? courseId,
    String? sectionId,
    String? title,
    String? description,
    String? topic,
    int? order,
    int? wordsCount,
    int? exercisesCount,
    int? durationMinutes,
    bool? isCompleted,
    double? progress,
    List<Word>? words,
    List<Exercise>? exercises,
    String? grammarRule,
    DateTime? createdAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      sectionId: sectionId ?? this.sectionId,
      title: title ?? this.title,
      description: description ?? this.description,
      topic: topic ?? this.topic,
      order: order ?? this.order,
      wordsCount: wordsCount ?? this.wordsCount,
      exercisesCount: exercisesCount ?? this.exercisesCount,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      words: words ?? this.words,
      exercises: exercises ?? this.exercises,
      grammarRule: grammarRule ?? this.grammarRule,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
