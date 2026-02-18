import 'package:uuid/uuid.dart';
import 'lesson.dart';

class Course {
  Course({
    String? id,
    required this.language,
    required this.level,
    required this.title,
    required this.description,
    this.imageUrl = '',
    this.lessonsCount = 0,
    this.wordsCount = 0,
    this.rating = 0.0,
    this.isPremium = false,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      language: json['language'] as String,
      level: json['level'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      lessonsCount: json['lessonsCount'] as int? ?? 0,
      wordsCount: json['wordsCount'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isPremium: json['isPremium'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  final String id;
  final String language;
  final String level;
  final String title;
  final String description;
  final String imageUrl;
  final int lessonsCount;
  final int wordsCount;
  final double rating;
  final bool isPremium;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'language': language,
      'level': level,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'lessonsCount': lessonsCount,
      'wordsCount': wordsCount,
      'rating': rating,
      'isPremium': isPremium,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class CourseSection {
  CourseSection({
    String? id,
    required this.courseId,
    required this.title,
    this.description = '',
    this.order = 0,
    this.lessons = const [],
  }) : id = id ?? const Uuid().v4();

  factory CourseSection.fromJson(Map<String, dynamic> json) {
    return CourseSection(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  final String id;
  final String courseId;
  final String title;
  final String description;
  final int order;
  final List<Lesson> lessons;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'order': order,
      'lessons': lessons.map((e) => e.toJson()).toList(),
    };
  }
}
