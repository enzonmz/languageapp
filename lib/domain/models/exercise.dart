import 'package:uuid/uuid.dart';
import 'word.dart';

class Exercise {
  Exercise({
    String? id,
    required this.lessonId,
    required this.type,
    required this.question,
    this.audioUrl,
    this.options = const [],
    required this.correctAnswer,
    this.explanation,
    this.order = 0,
    this.relatedWord,
  }) : id = id ?? const Uuid().v4();

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      type: json['type'] as String,
      question: json['question'] as String,
      audioUrl: json['audioUrl'] as String?,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String?,
      order: json['order'] as int? ?? 0,
      relatedWord: json['relatedWord'] != null
          ? Word.fromJson(json['relatedWord'] as Map<String, dynamic>)
          : null,
    );
  }
  final String id;
  final String lessonId;
  final String type;
  final String question;
  final String? audioUrl;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;
  final int order;
  final Word? relatedWord;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'type': type,
      'question': question,
      'audioUrl': audioUrl,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'order': order,
      'relatedWord': relatedWord?.toJson(),
    };
  }
}

class ExerciseResult {
  ExerciseResult({
    String? id,
    required this.exerciseId,
    required this.userId,
    required this.isCorrect,
    required this.userAnswer,
    DateTime? answeredAt,
    this.timeSpent = Duration.zero,
  })  : id = id ?? const Uuid().v4(),
        answeredAt = answeredAt ?? DateTime.now();

  factory ExerciseResult.fromJson(Map<String, dynamic> json) {
    return ExerciseResult(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      userId: json['userId'] as String,
      isCorrect: json['isCorrect'] as bool,
      userAnswer: json['userAnswer'] as String,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
      timeSpent: Duration(milliseconds: json['timeSpent'] as int? ?? 0),
    );
  }
  final String id;
  final String exerciseId;
  final String userId;
  final bool isCorrect;
  final String userAnswer;
  final DateTime answeredAt;
  final Duration timeSpent;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'userId': userId,
      'isCorrect': isCorrect,
      'userAnswer': userAnswer,
      'answeredAt': answeredAt.toIso8601String(),
      'timeSpent': timeSpent.inMilliseconds,
    };
  }
}
