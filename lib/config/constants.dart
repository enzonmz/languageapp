// Константы приложения

// Уровни владения языком
class LanguageLevel {
  static const String beginner = 'A1';
  static const String elementary = 'A2';
  static const String intermediate = 'B1';
  static const String upperIntermediate = 'B2';
  static const String advanced = 'C1';
  static const String proficiency = 'C2';

  static const List<String> all = [
    beginner,
    elementary,
    intermediate,
    upperIntermediate,
    advanced,
    proficiency,
  ];

  static String getName(String level) {
    switch (level) {
      case beginner:
        return 'Начинающий';
      case elementary:
        return 'Элементарный';
      case intermediate:
        return 'Средний';
      case upperIntermediate:
        return 'Выше среднего';
      case advanced:
        return 'Продвинутый';
      case proficiency:
        return 'Профессиональный';
      default:
        return level;
    }
  }
}

// Поддерживаемые языки
class SupportedLanguages {
  static const String english = 'en';
  static const String german = 'de';
  static const String turkish = 'tr';
  static const String french = 'fr';
  static const String spanish = 'es';
  static const String italian = 'it';

  static const List<String> all = [
    english,
    german,
    turkish,
    french,
    spanish,
    italian,
  ];

  static String getName(String code) {
    switch (code) {
      case english:
        return 'Английский';
      case german:
        return 'Немецкий';
      case turkish:
        return 'Турецкий';
      case french:
        return 'Французский';
      case spanish:
        return 'Испанский';
      case italian:
        return 'Итальянский';
      default:
        return code;
    }
  }
}

// Типы упражнений
class ExerciseType {
  static const String flashcard = 'flashcard';
  static const String choice = 'choice';
  static const String buildWord = 'build_word';
  static const String fillGap = 'fill_gap';
  static const String listening = 'listening';
  static const String pronunciation = 'pronunciation';

  static const List<String> all = [
    flashcard,
    choice,
    buildWord,
    fillGap,
    listening,
    pronunciation,
  ];

  static String getName(String type) {
    switch (type) {
      case flashcard:
        return 'Карточки';
      case choice:
        return 'Тест';
      case buildWord:
        return 'Составь слово';
      case fillGap:
        return 'Заполни пропуск';
      case listening:
        return 'Аудирование';
      case pronunciation:
        return 'Произношение';
      default:
        return type;
    }
  }
}

// Темы уроков
class LessonTopics {
  static const String food = 'food';
  static const String travel = 'travel';
  static const String school = 'school';
  static const String work = 'work';
  static const String slang = 'slang';
  static const String grammar = 'grammar';
  static const String business = 'business';
  static const String everyday = 'everyday';

  static const List<String> all = [
    food,
    travel,
    school,
    work,
    slang,
    grammar,
    business,
    everyday,
  ];

  static String getName(String topic) {
    switch (topic) {
      case food:
        return 'Еда';
      case travel:
        return 'Путешествия';
      case school:
        return 'Школа';
      case work:
        return 'Работа';
      case slang:
        return 'Сленг';
      case grammar:
        return 'Грамматика';
      case business:
        return 'Бизнес';
      case everyday:
        return 'Повседневная жизнь';
      default:
        return topic;
    }
  }
}

// Цели обучения
class DailyGoals {
  static const int fiveMinutes = 5;
  static const int tenMinutes = 10;
  static const int fifteenMinutes = 15;
  static const int thirtyMinutes = 30;

  static const List<int> all = [
    fiveMinutes,
    tenMinutes,
    fifteenMinutes,
    thirtyMinutes,
  ];

  static String getLabel(int minutes) {
    return '$minutes мин/день';
  }
}

// Временные интервалы SRS
class SRSIntervals {
  static const int again = 1; // 1 минута
  static const int hard = 10; // 10 минут
  static const int good = 1440; // 24 часа
  static const int easy = 4320; // 3 дня
}

// Ключи SharedPreferences
class PrefKeys {
  static const String onboardingCompleted = 'onboarding_completed';
  static const String userId = 'user_id';
  static const String authToken = 'auth_token';
  static const String selectedLanguage = 'selected_language';
  static const String selectedLevel = 'selected_level';
  static const String dailyGoal = 'daily_goal';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String notificationTime = 'notification_time';
  static const String notificationDays = 'notification_days';
  static const String speechSpeed = 'speech_speed';
  static const String darkMode = 'dark_mode';
  static const String streak = 'streak';
  static const String lastActivityDate = 'last_activity_date';
}

// Длительность анимаций
class AnimationDurations {
  static const short = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 400);
  static const long = Duration(milliseconds: 600);
}
