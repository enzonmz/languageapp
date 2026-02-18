import 'package:dio/dio.dart';
import '../../../config/supabase.dart';

class GrokService {
  static final GrokService _instance = GrokService._internal();
  factory GrokService() => _instance;
  GrokService._internal();

  final _dio = Dio();

  // Отправить сообщение AI и получить ответ
  Future<String> sendMessage(String message,
      {String? conversationHistory}) async {
    try {
      final systemPrompt = '''Ты - помощник по изучению языков. 
Ты помогаешь пользователю практиковать иностранный язык через разговор.
Отвечай кратко и по делу, исправляй ошибки мягко.
Если пользователь пишет на иностранном языке, поправляй его грамматику и предлагай лучшие варианты.
Ты должен быть дружелюбным и мотивирующим.''';

      final messages = [
        {'role': 'system', 'content': systemPrompt},
        if (conversationHistory != null)
          {'role': 'assistant', 'content': conversationHistory},
        {'role': 'user', 'content': message},
      ];

      final response = await _dio.post(
        '${GrokConfig.baseUrl}/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GrokConfig.apiKey}',
          },
        ),
        data: {
          'messages': messages,
          'model': GrokConfig.model,
          'stream': false,
          'temperature': 0.7,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final choices = data['choices'] as List;
        if (choices.isNotEmpty) {
          final message = choices[0]['message'] as Map<String, dynamic>;
          return message['content'] as String;
        }
      }

      return 'Извините, произошла ошибка. Попробуйте еще раз.';
    } catch (e) {
      return 'Ошибка связи с AI: $e';
    }
  }

  // Генерировать упражнение
  Future<String> generateExercise(String topic, String language) async {
    try {
      final response = await _dio.post(
        '${GrokConfig.baseUrl}/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GrokConfig.apiKey}',
          },
        ),
        data: {
          'messages': [
            {
              'role': 'system',
              'content':
                  'Ты - учитель языков. Создай простое упражнение на тему "$topic" для изучающих $language. Дай 5 фраз на $language с переводом на русский.'
            }
          ],
          'model': GrokConfig.model,
          'stream': false,
          'temperature': 0.7,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final choices = data['choices'] as List;
        if (choices.isNotEmpty) {
          final message = choices[0]['message'] as Map<String, dynamic>;
          return message['content'] as String;
        }
      }

      return 'Не удалось создать упражнение.';
    } catch (e) {
      return 'Ошибка: $e';
    }
  }

  // Объяснить грамматику
  Future<String> explainGrammar(String topic, String language) async {
    try {
      final response = await _dio.post(
        '${GrokConfig.baseUrl}/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${GrokConfig.apiKey}',
          },
        ),
        data: {
          'messages': [
            {
              'role': 'system',
              'content':
                  'Объясни грамматику "$topic" на $language простым языком для начинающих. Используй примеры.'
            }
          ],
          'model': GrokConfig.model,
          'stream': false,
          'temperature': 0.7,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final choices = data['choices'] as List;
        if (choices.isNotEmpty) {
          final message = choices[0]['message'] as Map<String, dynamic>;
          return message['content'] as String;
        }
      }

      return 'Не удалось получить объяснение.';
    } catch (e) {
      return 'Ошибка: $e';
    }
  }
}
