import '../../domain/models/course.dart';
import '../../domain/models/lesson.dart';
import '../../domain/models/word.dart';
import 'package:flutter/material.dart';

// Данные курсов с реальными уроками
class CourseData {
  // Курсы A1 (Начинающий)
  static final List<Course> a1Lessons = [
    Course(
      id: 'a1_1',
      language: 'Английский',
      level: 'A1',
      title: 'Приветствия',
      description: 'Основные приветствия и прощания',
      imageUrl: '👋',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.8,
    ),
    Course(
      id: 'a1_2',
      language: 'Английский',
      level: 'A1',
      title: 'Знакомство',
      description: 'Как представиться и спросить имя',
      imageUrl: '👤',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.6,
    ),
    Course(
      id: 'a1_3',
      language: 'Английский',
      level: 'A1',
      title: 'Семья',
      description: 'Члены семьи и отношения',
      imageUrl: '👨‍👩‍👧',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.7,
    ),
    Course(
      id: 'a1_4',
      language: 'Английский',
      level: 'A1',
      title: 'Числа 1-20',
      description: 'Основные числительные',
      imageUrl: '🔢',
      lessonsCount: 50,
      wordsCount: 400,
      rating: 4.9,
    ),
    Course(
      id: 'a1_5',
      language: 'Английский',
      level: 'A1',
      title: 'Цвета',
      description: 'Основные цвета',
      imageUrl: '🎨',
      lessonsCount: 50,
      wordsCount: 300,
      rating: 4.5,
    ),
    Course(
      id: 'a1_6',
      language: 'Английский',
      level: 'A1',
      title: 'Время',
      description: 'Часы и время суток',
      imageUrl: '🕐',
      lessonsCount: 50,
      wordsCount: 400,
      rating: 4.6,
    ),
    Course(
      id: 'a1_7',
      language: 'Английский',
      level: 'A1',
      title: 'Еда',
      description: 'Основные продукты питания',
      imageUrl: '🍎',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.8,
    ),
    Course(
      id: 'a1_8',
      language: 'Английский',
      level: 'A1',
      title: 'Напитки',
      description: 'Напитки и утренний кофе',
      imageUrl: '☕',
      lessonsCount: 50,
      wordsCount: 300,
      rating: 4.4,
    ),
    Course(
      id: 'a1_9',
      language: 'Английский',
      level: 'A1',
      title: 'Дни недели',
      description: 'Дни недели и планы',
      imageUrl: '📅',
      lessonsCount: 50,
      wordsCount: 300,
      rating: 4.7,
    ),
    Course(
      id: 'a1_10',
      language: 'Английский',
      level: 'A1',
      title: 'Месяцы',
      description: 'Месяцы и даты',
      imageUrl: '📆',
      lessonsCount: 50,
      wordsCount: 300,
      rating: 4.5,
    ),
  ];

  // Курсы A2 (Элементарный)
  static final List<Course> a2Lessons = [
    Course(
      id: 'a2_1',
      language: 'Английский',
      level: 'A2',
      title: 'Работа',
      description: 'Профессии и рабочие места',
      imageUrl: '💼',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.6,
    ),
    Course(
      id: 'a2_2',
      language: 'Английский',
      level: 'A2',
      title: 'Транспорт',
      description: 'Виды транспорта и поездки',
      imageUrl: '🚗',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.7,
    ),
    Course(
      id: 'a2_3',
      language: 'Английский',
      level: 'A2',
      title: 'Покупки',
      description: 'Магазины и одежда',
      imageUrl: '🛍️',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.5,
    ),
    Course(
      id: 'a2_4',
      language: 'Английский',
      level: 'A2',
      title: 'Здоровье',
      description: 'Части тела и самочувствие',
      imageUrl: '🏥',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.8,
    ),
    Course(
      id: 'a2_5',
      language: 'Английский',
      level: 'A2',
      title: 'Погода',
      description: 'Погодные явления',
      imageUrl: '🌤️',
      lessonsCount: 50,
      wordsCount: 400,
      rating: 4.4,
    ),
    Course(
      id: 'a2_6',
      language: 'Английский',
      level: 'A2',
      title: 'Дом',
      description: 'Комнаты и мебель',
      imageUrl: '🏠',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.6,
    ),
    Course(
      id: 'a2_7',
      language: 'Английский',
      level: 'A2',
      title: 'Города',
      description: 'Места в городе',
      imageUrl: '🏙️',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.5,
    ),
    Course(
      id: 'a2_8',
      language: 'Английский',
      level: 'A2',
      title: 'Путешествия',
      description: 'Бронирование и аэропорт',
      imageUrl: '✈️',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.7,
    ),
    Course(
      id: 'a2_9',
      language: 'Английский',
      level: 'A2',
      title: 'Хобби',
      description: 'Свободное время и увлечения',
      imageUrl: '🎯',
      lessonsCount: 50,
      wordsCount: 500,
      rating: 4.6,
    ),
    Course(
      id: 'a2_10',
      language: 'Английский',
      level: 'A2',
      title: 'Праздники',
      description: 'Праздники и традиции',
      imageUrl: '🎄',
      lessonsCount: 50,
      wordsCount: 400,
      rating: 4.5,
    ),
  ];

  // Курсы B1 (Средний)
  static final List<Course> b1Lessons = [
    Course(
      id: 'b1_1',
      language: 'Английский',
      level: 'B1',
      title: 'Бизнес',
      description: 'Деловая переписка',
      imageUrl: '📊',
      lessonsCount: 50,
      wordsCount: 800,
      rating: 4.7,
    ),
    Course(
      id: 'b1_2',
      language: 'Английский',
      level: 'B1',
      title: 'Образование',
      description: 'Университеты и экзамены',
      imageUrl: '🎓',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.6,
    ),
    Course(
      id: 'b1_3',
      language: 'Английский',
      level: 'B1',
      title: 'Технологии',
      description: 'Гаджеты и интернет',
      imageUrl: '💻',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.8,
    ),
    Course(
      id: 'b1_4',
      language: 'Английский',
      level: 'B1',
      title: 'Искусство',
      description: 'Музыка, кино, театр',
      imageUrl: '🎭',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.5,
    ),
    Course(
      id: 'b1_5',
      language: 'Английский',
      level: 'B1',
      title: 'Спорт',
      description: 'Виды спорта и фитнес',
      imageUrl: '⚽',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.6,
    ),
    Course(
      id: 'b1_6',
      language: 'Английский',
      level: 'B1',
      title: 'Природа',
      description: 'Животные и растения',
      imageUrl: '🌿',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.5,
    ),
    Course(
      id: 'b1_7',
      language: 'Английский',
      level: 'B1',
      title: 'Здоровый образ',
      description: 'Диета и упражнения',
      imageUrl: '🥗',
      lessonsCount: 50,
      wordsCount: 600,
      rating: 4.7,
    ),
    Course(
      id: 'b1_8',
      language: 'Английский',
      level: 'B1',
      title: 'Политика',
      description: 'Новости и события',
      imageUrl: '📰',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.4,
    ),
    Course(
      id: 'b1_9',
      language: 'Английский',
      level: 'B1',
      title: 'Наука',
      description: 'Открытия и исследования',
      imageUrl: '🔬',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.6,
    ),
    Course(
      id: 'b1_10',
      language: 'Английский',
      level: 'B1',
      title: 'Культура',
      description: 'Традиции разных стран',
      imageUrl: '🌍',
      lessonsCount: 50,
      wordsCount: 700,
      rating: 4.5,
    ),
  ];

  // Получить все курсы
  static List<Course> getAllCourses() {
    return [...a1Lessons, ...a2Lessons, ...b1Lessons];
  }

  // Получить уроки для курса
  static List<Lesson> getLessonsForCourse(String courseId) {
    final course = getAllCourses().firstWhere(
      (c) => c.id == courseId,
      orElse: () => Course(
        id: courseId,
        language: 'Английский',
        level: 'A1',
        title: courseId,
        description: '',
        imageUrl: '📚',
        lessonsCount: 50,
        wordsCount: 500,
        rating: 4.5,
      ),
    );

    // Генерируем 50 уроков для каждого курса
    return List.generate(50, (index) {
      final lessonNumber = index + 1;
      return Lesson(
        id: '${courseId}_lesson_$lessonNumber',
        courseId: courseId,
        sectionId: courseId,
        title: 'Урок $lessonNumber',
        description: _getLessonDescription(courseId, lessonNumber),
        topic: course.title,
        order: lessonNumber,
        wordsCount: 5 + (lessonNumber % 3),
        words: _generateWordsForLesson(courseId, lessonNumber),
      );
    });
  }

  static String _getLessonDescription(String courseId, int lessonNumber) {
    final descriptions = {
      'a1_1': ['Базовая приветствия', 'Прощания', 'Вежливые формы'],
      'a1_2': ['Представление себя', 'Спрашивать имя', 'Имена'],
      'a1_3': ['Мама и папа', 'Братья и сёстры', 'Бабушка и дедушка'],
      'a1_4': ['Числа 1-10', 'Числа 11-20', 'Простые математика'],
      'a1_5': ['Красный и синий', 'Зелёный и жёлтый', 'Все цвета'],
    };

    final key = courseId.split('_').take(2).join('_');
    final list = descriptions[key] ?? ['Урок $lessonNumber'];
    final index = (lessonNumber - 1) % list.length;
    return list[index];
  }

  static List<Word> _generateWordsForLesson(String courseId, int lessonNumber) {
    final words = <Word>[];
    final baseWords = _getBaseWordsForCourse(courseId);

    // Выбираем 5-7 слов для урока
    for (int i = 0; i < 5 + (lessonNumber % 3); i++) {
      final wordIndex = (lessonNumber * 10 + i) % baseWords.length;
      words.add(Word(
        id: '${courseId}_word_${lessonNumber}_$i',
        word: baseWords[wordIndex]['word'] as String,
        translation: baseWords[wordIndex]['translation'] as String,
        transcription: baseWords[wordIndex]['transcription'] as String?,
        examples: (baseWords[wordIndex]['examples'] as List).cast<String>(),
      ));
    }

    return words;
  }

  static List<Map<String, dynamic>> _getBaseWordsForCourse(String courseId) {
    final allWords = [
      // A1 Приветствия
      {
        'word': 'Hello',
        'translation': 'Привет',
        'transcription': '[həˈləʊ]',
        'examples': ['Hello! How are you?', 'Hello, my friend!']
      },
      {
        'word': 'Goodbye',
        'translation': 'До свидания',
        'transcription': '[ˌɡʊdˈbaɪ]',
        'examples': ['Goodbye! See you later.', 'Goodbye, my friend!']
      },
      {
        'word': 'Thank you',
        'translation': 'Спасибо',
        'transcription': '[θæŋk juː]',
        'examples': ['Thank you very much!', 'Thank you for help.']
      },
      {
        'word': 'Please',
        'translation': 'Пожалуйста',
        'transcription': '[pliːz]',
        'examples': ['Please, help me.', 'Can you help me, please?']
      },
      {
        'word': 'Good morning',
        'translation': 'Доброе утро',
        'transcription': '[ˌɡʊd ˈmɔːnɪŋ]',
        'examples': ['Good morning! Nice to see you.', 'Good morning, Mom!']
      },
      {
        'word': 'Good evening',
        'translation': 'Добрый вечер',
        'transcription': '[ˌɡʊd ˈiːvnɪŋ]',
        'examples': [
          'Good evening! How was your day?',
          'Good evening, everyone.'
        ]
      },
      {
        'word': 'Good night',
        'translation': 'Спокойной ночи',
        'transcription': '[ˌɡʊd ˈnaɪt]',
        'examples': [
          'Good night! Sweet dreams.',
          'Good night, see you tomorrow.'
        ]
      },
      {
        'word': 'How are you?',
        'translation': 'Как дела?',
        'transcription': '[haʊ ɑːr juː]',
        'examples': ['How are you today?', 'How are you? I am fine.']
      },
      {
        'word': 'Nice to meet you',
        'translation': 'Приятно познакомиться',
        'transcription': '[naɪs tuː miːt juː]',
        'examples': ['Nice to meet you!', 'Very nice to meet you.']
      },
      {
        'word': 'See you later',
        'translation': 'Увидимся позже',
        'transcription': '[siː juː ˈleɪtər]',
        'examples': ['See you later!', 'See you later, my friend.']
      },
      // A1 Знакомство
      {
        'word': 'My name is',
        'translation': 'Меня зовут',
        'transcription': '[maɪ neɪm ɪz]',
        'examples': ['My name is Anna.', 'What is your name?']
      },
      {
        'word': 'I am from',
        'translation': 'Я из',
        'transcription': '[aɪ æm frʌm]',
        'examples': ['I am from Moscow.', 'Where are you from?']
      },
      {
        'word': 'What is your name?',
        'translation': 'Как тебя зовут?',
        'transcription': '[wɒt ɪz jɔːr neɪm]',
        'examples': ['What is your name?', 'My name is Dmitriy.']
      },
      {
        'word': 'How old are you?',
        'translation': 'Сколько тебе лет?',
        'transcription': '[haʊ əʊld ɑːr juː]',
        'examples': ['How old are you?', 'I am 25 years old.']
      },
      {
        'word': 'Where do you live?',
        'translation': 'Где ты живёшь?',
        'transcription': '[weər duː juː lɪv]',
        'examples': ['Where do you live?', 'I live in Moscow.']
      },
      {
        'word': 'Nice to see you',
        'translation': 'Рад тебя видеть',
        'transcription': '[naɪs tuː siː juː]',
        'examples': ['Nice to see you!', 'Good to see you again.']
      },
      {
        'word': 'What do you do?',
        'translation': 'Чем ты занимаешься?',
        'transcription': '[wɒt duː juː duː]',
        'examples': ['What do you do?', 'I am a student.']
      },
      {
        'word': 'I am a student',
        'translation': 'Я студент',
        'transcription': '[aɪ æm ə ˈstjuːdnt]',
        'examples': ['I am a student.', 'She is a student too.']
      },
      {
        'word': 'I work as',
        'translation': 'Я работаю как',
        'transcription': '[aɪ wɜːrk æz]',
        'examples': ['I work as a teacher.', 'What do you work as?']
      },
      {
        'word': 'Nice to meet you too',
        'translation': 'Взаимно приятно',
        'transcription': '[naɪs tuː miːt juː tuː]',
        'examples': ['Nice to meet you too!', 'Pleased to meet you.']
      },
      // A1 Семья
      {
        'word': 'Mother',
        'translation': 'Мама',
        'transcription': '[ˈmʌðər]',
        'examples': ['My mother is kind.', 'I love my mother.']
      },
      {
        'word': 'Father',
        'translation': 'Папа',
        'transcription': '[ˈfɑːðər]',
        'examples': ['My father works a lot.', 'I see my father on weekends.']
      },
      {
        'word': 'Parents',
        'translation': 'Родители',
        'transcription': '[ˈpeərənts]',
        'examples': [
          'My parents live in Moscow.',
          'I call my parents every day.'
        ]
      },
      {
        'word': 'Sister',
        'translation': 'Сестра',
        'transcription': '[ˈsɪstər]',
        'examples': ['My sister is younger.', 'I have one sister.']
      },
      {
        'word': 'Brother',
        'translation': 'Брат',
        'transcription': '[ˈbrʌðər]',
        'examples': ['My brother is older.', 'I play with my brother.']
      },
      {
        'word': 'Grandmother',
        'translation': 'Бабушка',
        'transcription': '[ˈɡrændˌmʌðər]',
        'examples': ['My grandmother cooks well.', 'I visit my grandmother.']
      },
      {
        'word': 'Grandfather',
        'translation': 'Дедушка',
        'transcription': '[ˈɡrændˌfɑːðər]',
        'examples': ['My grandfather tells stories.', 'I love my grandfather.']
      },
      {
        'word': 'Family',
        'translation': 'Семья',
        'transcription': '[ˈfæmɪli]',
        'examples': ['My family is big.', 'I love my family.']
      },
      {
        'word': 'Son',
        'translation': 'Сын',
        'transcription': '[sʌn]',
        'examples': ['I have one son.', 'My son is five years old.']
      },
      {
        'word': 'Daughter',
        'translation': 'Дочь',
        'transcription': '[ˈdɔːtər]',
        'examples': ['I have a daughter.', 'My daughter is seven.']
      },
      // A1 Числа
      {
        'word': 'One',
        'translation': 'Один',
        'transcription': '[wʌn]',
        'examples': ['I have one apple.', 'Room number one.']
      },
      {
        'word': 'Two',
        'translation': 'Два',
        'transcription': '[tuː]',
        'examples': ['Two books, please.', 'I have two sisters.']
      },
      {
        'word': 'Three',
        'translation': 'Три',
        'transcription': '[θriː]',
        'examples': ['Three times a week.', 'Three people came.']
      },
      {
        'word': 'Four',
        'translation': 'Четыре',
        'transcription': '[fɔːr]',
        'examples': ['Four walls.', 'Four in the morning.']
      },
      {
        'word': 'Five',
        'translation': 'Пять',
        'transcription': '[faɪv]',
        'examples': ['Five minutes.', 'I am five years old.']
      },
      {
        'word': 'Six',
        'translation': 'Шесть',
        'transcription': '[sɪks]',
        'examples': ['Six o clock.', 'Six people in total.']
      },
      {
        'word': 'Seven',
        'translation': 'Семь',
        'transcription': '[ˈsevn]',
        'examples': ['Seven days a week.', 'Chapter seven.']
      },
      {
        'word': 'Eight',
        'translation': 'Восемь',
        'transcription': '[eɪt]',
        'examples': ['Eight hours.', 'Room number eight.']
      },
      {
        'word': 'Nine',
        'translation': 'Девять',
        'transcription': '[naɪn]',
        'examples': ['Nine o clock.', 'Nine months pregnant.']
      },
      {
        'word': 'Ten',
        'translation': 'Десять',
        'transcription': '[ten]',
        'examples': ['Ten dollars.', 'From one to ten.']
      },
      {
        'word': 'Eleven',
        'translation': 'Одиннадцать',
        'transcription': '[ɪˈlevn]',
        'examples': ['Eleven years old.', 'At eleven o clock.']
      },
      {
        'word': 'Twelve',
        'translation': 'Двенадцать',
        'transcription': '[twelv]',
        'examples': ['Twelve months.', 'At twelve o clock.']
      },
      {
        'word': 'Thirteen',
        'translation': 'Тринадцать',
        'transcription': '[ˌθɜːrˈtiːn]',
        'examples': ['Thirteen years old.', 'Page thirteen.']
      },
      {
        'word': 'Fourteen',
        'translation': 'Четырнадцать',
        'transcription': '[ˌfɔːrˈtiːn]',
        'examples': ['Fourteen days.', 'At fourteen years old.']
      },
      {
        'word': 'Fifteen',
        'translation': 'Пятнадцать',
        'transcription': '[ˌfɪfˈtiːn]',
        'examples': ['Fifteen minutes.', 'At fifteen past.']
      },
      {
        'word': 'Sixteen',
        'translation': 'Шестнадцать',
        'transcription': '[ˌsɪksˈtiːn]',
        'examples': ['Sixteen years old.', 'Chapter sixteen.']
      },
      {
        'word': 'Seventeen',
        'translation': 'Семнадцать',
        'transcription': '[ˌsevnˈtiːn]',
        'examples': ['Seventeen people.', 'At seventeen.']
      },
      {
        'word': 'Eighteen',
        'translation': 'Восемнадцать',
        'transcription': '[ˌeɪˈtiːn]',
        'examples': ['Eighteen years old.', 'At eighteen.']
      },
      {
        'word': 'Nineteen',
        'translation': 'Девятнадцать',
        'transcription': '[ˌnaɪnˈtiːn]',
        'examples': ['Nineteen dollars.', 'At nineteen past.']
      },
      {
        'word': 'Twenty',
        'translation': 'Двадцать',
        'transcription': '[ˈtwenti]',
        'examples': ['Twenty minutes.', 'Number twenty.']
      },
      // A1 Цвета
      {
        'word': 'Red',
        'translation': 'Красный',
        'transcription': '[red]',
        'examples': ['A red apple.', 'The car is red.']
      },
      {
        'word': 'Blue',
        'translation': 'Синий',
        'transcription': '[bluː]',
        'examples': ['The sky is blue.', 'Blue eyes.']
      },
      {
        'word': 'Green',
        'translation': 'Зелёный',
        'transcription': '[ɡriːn]',
        'examples': ['Green grass.', 'The tree is green.']
      },
      {
        'word': 'Yellow',
        'translation': 'Жёлтый',
        'transcription': '[ˈjeləʊ]',
        'examples': ['Yellow sun.', 'Yellow flowers.']
      },
      {
        'word': 'Orange',
        'translation': 'Оранжевый',
        'transcription': '[ˈɒrɪndʒ]',
        'examples': ['An orange fruit.', 'Orange color.']
      },
      {
        'word': 'White',
        'translation': 'Белый',
        'transcription': '[waɪt]',
        'examples': ['White snow.', 'White house.']
      },
      {
        'word': 'Black',
        'translation': 'Чёрный',
        'transcription': '[blæk]',
        'examples': ['Black cat.', 'Black coffee.']
      },
      {
        'word': 'Pink',
        'translation': 'Розовый',
        'transcription': '[pɪŋk]',
        'examples': ['Pink flowers.', 'Pink dress.']
      },
      {
        'word': 'Purple',
        'translation': 'Фиолетовый',
        'transcription': '[ˈpɜːpl]',
        'examples': ['Purple color.', 'Purple grapes.']
      },
      {
        'word': 'Brown',
        'translation': 'Коричневый',
        'transcription': '[braʊn]',
        'examples': ['Brown eyes.', 'Brown bread.']
      },
      // A1 Время
      {
        'word': 'Time',
        'translation': 'Время',
        'transcription': '[taɪm]',
        'examples': ['What time is it?', 'Time to go.']
      },
      {
        'word': 'Hour',
        'translation': 'Час',
        'transcription': '[aʊər]',
        'examples': ['One hour.', 'Two hours.']
      },
      {
        'word': 'Minute',
        'translation': 'Минута',
        'transcription': '[ˈmɪnɪt]',
        'examples': ['Five minutes.', 'Wait a minute!']
      },
      {
        'word': 'Second',
        'translation': 'Секунда',
        'transcription': '[ˈsekənd]',
        'examples': ['One second, please.', 'Wait a second.']
      },
      {
        'word': 'Morning',
        'translation': 'Утро',
        'transcription': '[ˈmɔːnɪŋ]',
        'examples': ['Good morning!', 'In the morning.']
      },
      {
        'word': 'Afternoon',
        'translation': 'День (время суток)',
        'transcription': '[ˌɑːftərˈnuːn]',
        'examples': ['In the afternoon.', 'Good afternoon!']
      },
      {
        'word': 'Evening',
        'translation': 'Вечер',
        'transcription': '[ˈiːvnɪŋ]',
        'examples': ['In the evening.', 'Good evening!']
      },
      {
        'word': 'Night',
        'translation': 'Ночь',
        'transcription': '[naɪt]',
        'examples': ['At night.', 'Good night!']
      },
      {
        'word': 'Today',
        'translation': 'Сегодня',
        'transcription': '[təˈdeɪ]',
        'examples': ['Today is Monday.', 'What are you doing today?']
      },
      {
        'word': 'Tomorrow',
        'translation': 'Завтра',
        'transcription': '[təˈmɒrəʊ]',
        'examples': ['See you tomorrow!', 'Tomorrow I will go.']
      },
      {
        'word': 'Yesterday',
        'translation': 'Вчера',
        'transcription': '[ˈjestədeɪ]',
        'examples': ['Yesterday was Sunday.', 'I saw him yesterday.']
      },
      // A1 Еда
      {
        'word': 'Apple',
        'translation': 'Яблоко',
        'transcription': '[ˈæpl]',
        'examples': ['An apple a day.', 'I like apples.']
      },
      {
        'word': 'Bread',
        'translation': 'Хлеб',
        'transcription': '[bred]',
        'examples': ['Bread and butter.', 'Fresh bread.']
      },
      {
        'word': 'Water',
        'translation': 'Вода',
        'transcription': '[ˈwɔːtər]',
        'examples': ['Water, please.', 'Drink water.']
      },
      {
        'word': 'Milk',
        'translation': 'Молоко',
        'transcription': '[mɪlk]',
        'examples': ['A glass of milk.', 'Milk is white.']
      },
      {
        'word': 'Cheese',
        'translation': 'Сыр',
        'transcription': '[tʃiːz]',
        'examples': ['Cheese sandwich.', 'I like cheese.']
      },
      {
        'word': 'Meat',
        'translation': 'Мясо',
        'transcription': '[miːt]',
        'examples': ['Chicken meat.', 'I eat meat.']
      },
      {
        'word': 'Fish',
        'translation': 'Рыба',
        'transcription': '[fɪʃ]',
        'examples': ['Fish and chips.', 'I like fish.']
      },
      {
        'word': 'Egg',
        'translation': 'Яйцо',
        'transcription': '[eɡ]',
        'examples': ['Boiled egg.', 'Eggs for breakfast.']
      },
      {
        'word': 'Rice',
        'translation': 'Рис',
        'transcription': '[raɪs]',
        'examples': ['Rice and meat.', 'Boiled rice.']
      },
      {
        'word': 'Fruit',
        'translation': 'Фрукт',
        'transcription': '[fruːt]',
        'examples': ['Fresh fruit.', 'Fruit salad.']
      },
      {
        'word': 'Vegetable',
        'translation': 'Овощ',
        'transcription': '[ˈvedʒtəbl]',
        'examples': ['Fresh vegetables.', 'Vegetable soup.']
      },
      {
        'word': 'Butter',
        'translation': 'Масло',
        'transcription': '[ˈbʌtər]',
        'examples': ['Bread and butter.', 'Butter on bread.']
      },
      {
        'word': 'Sugar',
        'translation': 'Сахар',
        'transcription': '[ˈʃʊɡər]',
        'examples': ['Sugar and coffee.', 'Too much sugar.']
      },
      {
        'word': 'Salt',
        'translation': 'Соль',
        'transcription': '[sɔːlt]',
        'examples': ['Salt and pepper.', 'Pass the salt, please.']
      },
      {
        'word': 'Coffee',
        'translation': 'Кофе',
        'transcription': '[ˈkɒfi]',
        'examples': ['Coffee with milk.', 'Two coffees, please.']
      },
      {
        'word': 'Tea',
        'translation': 'Чай',
        'transcription': '[tiː]',
        'examples': ['Cup of tea.', 'Tea with lemon.']
      },
      {
        'word': 'Juice',
        'translation': 'Сок',
        'transcription': '[dʒuːs]',
        'examples': ['Orange juice.', 'Fresh juice.']
      },
      {
        'word': 'Cake',
        'translation': 'Торт',
        'transcription': '[keɪk]',
        'examples': ['Birthday cake.', 'A piece of cake.']
      },
      {
        'word': 'Soup',
        'translation': 'Суп',
        'transcription': '[suːp]',
        'examples': ['Hot soup.', 'Vegetable soup.']
      },
      {
        'word': 'Chicken',
        'translation': 'Курица',
        'transcription': '[ˈtʃɪkɪn]',
        'examples': ['Chicken soup.', 'Grilled chicken.']
      },
    ];

    return allWords;
  }
}
