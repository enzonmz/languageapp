import 'package:uuid/uuid.dart';

class Word {
  // 0.0 - 1.0

  Word({
    String? id,
    required this.word,
    required this.translation,
    this.transcription,
    this.audioUrl,
    this.imageUrl,
    this.examples = const [],
    this.partOfSpeech,
    this.grammarGender,
    this.pluralForm,
    this.pastTense,
    this.lastReviewedAt,
    this.reviewCount = 0,
    this.correctCount = 0,
    this.incorrectCount = 0,
    this.masteryLevel = 0.0,
  }) : id = id ?? const Uuid().v4();

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] as String,
      word: json['word'] as String,
      translation: json['translation'] as String,
      transcription: json['transcription'] as String?,
      audioUrl: json['audioUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      partOfSpeech: json['partOfSpeech'] as String?,
      grammarGender: json['grammarGender'] as String?,
      pluralForm: json['pluralForm'] as String?,
      pastTense: json['pastTense'] as String?,
      lastReviewedAt: json['lastReviewedAt'] != null
          ? DateTime.parse(json['lastReviewedAt'] as String)
          : null,
      reviewCount: json['reviewCount'] as int? ?? 0,
      correctCount: json['correctCount'] as int? ?? 0,
      incorrectCount: json['incorrectCount'] as int? ?? 0,
      masteryLevel: (json['masteryLevel'] as num?)?.toDouble() ?? 0.0,
    );
  }
  final String id;
  final String word;
  final String translation;
  final String? transcription;
  final String? audioUrl;
  final String? imageUrl;
  final List<String> examples;
  final String? partOfSpeech;
  final String? grammarGender;
  final String? pluralForm;
  final String? pastTense;
  DateTime? lastReviewedAt;
  int reviewCount;
  int correctCount;
  int incorrectCount;
  double masteryLevel;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'translation': translation,
      'transcription': transcription,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'examples': examples,
      'partOfSpeech': partOfSpeech,
      'grammarGender': grammarGender,
      'pluralForm': pluralForm,
      'pastTense': pastTense,
      'lastReviewedAt': lastReviewedAt?.toIso8601String(),
      'reviewCount': reviewCount,
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'masteryLevel': masteryLevel,
    };
  }

  double get accuracy {
    if (reviewCount == 0) return 0.0;
    return correctCount / reviewCount;
  }

  Word copyWith({
    String? id,
    String? word,
    String? translation,
    String? transcription,
    String? audioUrl,
    String? imageUrl,
    List<String>? examples,
    String? partOfSpeech,
    String? grammarGender,
    String? pluralForm,
    String? pastTense,
    DateTime? lastReviewedAt,
    int? reviewCount,
    int? correctCount,
    int? incorrectCount,
    double? masteryLevel,
  }) {
    return Word(
      id: id ?? this.id,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      transcription: transcription ?? this.transcription,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      examples: examples ?? this.examples,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      grammarGender: grammarGender ?? this.grammarGender,
      pluralForm: pluralForm ?? this.pluralForm,
      pastTense: pastTense ?? this.pastTense,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      reviewCount: reviewCount ?? this.reviewCount,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      masteryLevel: masteryLevel ?? this.masteryLevel,
    );
  }
}
