import 'dart:convert';
import 'package:get/get.dart';
import 'grok_service.dart';
import '../../domain/models/word.dart';
import '../../domain/models/exercise.dart';
import '../../domain/models/course.dart';
import '../../domain/models/lesson.dart';
import '../local/local_database.dart';
import '../../config/constants.dart';

/// Сервис для генерации учебного контента через Grok AI
class ContentGeneratorService extends GetxService {
  final grokService = GrokService();
  final db = LocalDatabase();

  /// Темы для генерации курсов
  static const List<String> topics = [
    'Greetings and Farewells',
    'Family Members',
    'Numbers 1-20',
    'Colors',
    'Time and Clock',
    'Food and Drinks',
    'Days of the Week',
    'Months and Dates',
    'Clothing',
    'Body Parts',
    'House and Home',
    'School and Education',
    'Work and Jobs',
    'Transportation',
    'Shopping',
    'Weather',
    'Health',
    'Travel',
    'Hobbies',
    'Nature',
    'Animals',
    'Technology',
    'Business',
    'Sports',
    'Art and Culture',
  ];

  /// Типы упражнений
  static const List<String> exerciseTypes = [
    'translation',
    'choice',
    'fill_blank',
    'matching',
    'listening',
  ];

  /// Генерация курса по теме
  Future<Course> generateCourse(String topic, String level) async {
    final prompt = '''
    Create a language learning course for English.
    Topic: $topic
    Level: $level
    
    Return ONLY valid JSON object with this format:
    {
      "id": "course_${DateTime.now().millisecondsSinceEpoch}",
      "title": "Course title in English",
      "description": "Brief description of the course",
      "language": "English",
      "level": "$level",
      "lessonsCount": 5,
      "wordsCount": 40,
      "duration": "3 hours"
    }
    ''';

    final response = await grokService.sendMessage(prompt);
    final Map<String, dynamic> json = jsonDecode(response);

    return Course.fromJson({
      ...json,
      'id': 'course_${DateTime.now().millisecondsSinceEpoch}',
      'language': 'English',
      'level': level,
    });
  }

  /// Генерация урока с словами
  Future<Lesson> generateLesson(
      String courseId, String topic, int lessonNumber) async {
    final prompt = '''
    Generate vocabulary lesson for learning English.
    Topic: $topic
    Lesson Number: $lessonNumber
    Number of words: 8-10

    Return ONLY valid JSON object with this format:
    {
      "id": "${courseId}_lesson_$lessonNumber",
      "courseId": "$courseId",
      "title": "Lesson $lessonNumber: $topic",
      "sectionId": "$courseId",
      "words": [
        {
          "word": "english word",
          "translation": "russian translation",
          "transcription": "[phonetic]",
          "examples": ["example sentence 1", "example sentence 2"]
        }
      ],
      "grammarNote": "Brief grammar explanation if applicable"
    }
    ''';

    final response = await grokService.sendMessage(prompt);
    final Map<String, dynamic> json = jsonDecode(response);

    final words = (json['words'] as List).map((w) {
      return Word(
        word: w['word'] ?? '',
        translation: w['translation'] ?? '',
        transcription: w['transcription'],
        examples: List<String>.from(w['examples'] ?? []),
      );
    }).toList();

    return Lesson.fromJson({
      ...json,
      'courseId': courseId,
      'sectionId': courseId,
      'words': words,
    });
  }

  /// Генерация упражнений из списка слов
  Future<List<Exercise>> generateExercises(
      String courseId, int lessonNumber, List<Word> words) async {
    final List<Exercise> exercises = [];
    final lessonId = '${courseId}_lesson_$lessonNumber';

    for (int i = 0; i < words.length && i < 5; i++) {
      final word = words[i];
      final otherWords = words.where((w) => w.word != word.word).toList()
        ..shuffle();
      final options = [word.translation] +
          otherWords.take(3).map((w) => w.translation).toList()
        ..shuffle();

      exercises.add(Exercise(
        lessonId: lessonId,
        type: 'translation',
        question: word.word,
        correctAnswer: word.translation,
        options: options.take(4).toList(),
        relatedWord: word,
      ));
    }

    return exercises;
  }

  /// Генерация упражнений через Grok с AI
  Future<List<Exercise>> generateExercisesWithAI(
      String courseId, int lessonNumber, List<Word> words) async {
    final wordsJson = words
        .map((w) => {
              'word': w.word,
              'translation': w.translation,
              'example': w.examples.isNotEmpty ? w.examples.first : '',
            })
        .toList();

    final prompt = '''
    Create vocabulary exercises for learning English.
    Course: $courseId
    Lesson: $lessonNumber
    Words: ${jsonEncode(wordsJson)}

    Generate 5 different exercises mixing types: translation, choice, fill_blank.
    Return ONLY valid JSON array:
    [
      {
        "id": "ex_1",
        "lessonId": "${courseId}_lesson_$lessonNumber",
        "type": "translation",
        "question": "english word",
        "correctAnswer": "russian translation",
        "options": ["option1", "option2", "option3"]
      }
    ]
    ''';

    try {
      final response = await grokService.sendMessage(prompt);
      final List<dynamic> json = jsonDecode(response);
      return json.map((e) => Exercise.fromJson(e)).toList();
    } catch (e) {
      // Fallback: generate simple exercises
      return generateExercises(courseId, lessonNumber, words);
    }
  }

  /// Генерация диалога для практики
  Future<String> generateDialog(String topic, String level) async {
    final prompt = '''
    Create a short dialogue for learning English.
    Topic: $topic
    Level: $level

    Return ONLY the dialogue in this format:
    A: Hello!
    B: Hi! How are you?
    A: I'm fine, thank you.
    ''';

    return await grokService.sendMessage(prompt);
  }

  /// Генерация объяснения грамматики
  Future<String> generateGrammarExplanation(String topic, String level) async {
    final prompt = '''
    Explain the grammar topic for learning English.
    Topic: $topic
    Level: $level

    Provide a brief explanation (2-3 sentences) and one example.
    ''';

    return await grokService.sendMessage(prompt);
  }

  /// Генерация перевода предложения
  Future<String> translateSentence(String sentence, String targetLang) async {
    final prompt = '''
    Translate this sentence to $targetLang.
    Sentence: $sentence
    
    Return ONLY the translation.
    ''';

    return await grokService.sendMessage(prompt);
  }

  /// Сохранение сгенерированного урока в локальную БД
  Future<void> saveGeneratedLesson(Lesson lesson) async {
    final userId = LocalDatabase().getSetting(PrefKeys.userId) as String?;
    if (userId == null) return;

    // Сохраняем слова
    for (final word in lesson.words) {
      await db.saveWord(userId, {
        'id': '${lesson.courseId}_${word.word}',
        'word': word.word,
        'translation': word.translation,
        'transcription': word.transcription,
        'examples': word.examples,
        'lessonId': lesson.id,
        'courseId': lesson.courseId,
        'nextReviewAt':
            DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        'interval': 1,
        'easeFactor': 2.5,
      });
    }
  }

  /// Генерация полного курса и сохранение
  Future<void> generateAndSaveCourse(String topic, String level) async {
    final course = await generateCourse(topic, level);

    for (int i = 1; i <= 5; i++) {
      final lesson = await generateLesson(course.id, topic, i);
      await saveGeneratedLesson(lesson);
    }

    print('Сгенерирован курс: ${course.title}');
  }

  /// Получение списка доступных тем
  static List<String> getAvailableTopics() => topics;

  /// Получение темы по индексу
  static String getTopicByIndex(int index) {
    if (index >= 0 && index < topics.length) {
      return topics[index];
    }
    return topics[0];
  }

  /// Получение всех уровней
  static List<String> getLevels() => ['A1', 'A2', 'B1', 'B2', 'C1'];
}
