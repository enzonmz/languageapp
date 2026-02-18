import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/remote/grok_service.dart';
import '../../../config/routes.dart';
import '../../../config/constants.dart';
import '../../../data/local/local_database.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final GrokService _grokService = GrokService();
  bool _isLoading = false;
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage =
        LocalDatabase().getSetting(PrefKeys.selectedLanguage) as String?;
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add({
        'role': 'assistant',
        'content':
            'Привет! Я твой AI- помощник для изучения языков. Давай практиковаться! Напиши что-нибудь на языке, который ты изучаешь, или выбери тему для разговора.',
      });
    });
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    _messageController.clear();

    // Прокрутка вниз
    await Future.delayed(const Duration(milliseconds: 100));

    final response = await _grokService.sendMessage(message);

    setState(() {
      _messages.add({'role': 'assistant', 'content': response});
      _isLoading = false;
    });
  }

  Future<void> _generateExercise() async {
    if (_selectedLanguage == null || _selectedLanguage!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Сначала выберите язык в настройках')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final exercise = await _grokService.generateExercise(
      'повседневные фразы',
      SupportedLanguages.getName(_selectedLanguage!),
    );

    setState(() {
      _messages.add({
        'role': 'assistant',
        'content': 'Вот упражнение для вас:\\n\\n$exercise'
      });
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Практика'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: _isLoading ? null : _generateExercise,
            tooltip: 'Создать упражнение',
          ),
        ],
      ),
      body: Column(
        children: [
          // Язык для практики
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 12),
                Text(
                  'Язык: ${SupportedLanguages.getName(_selectedLanguage ?? 'en')}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          // Список сообщений
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF6C63FF)
                          : Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: Text(
                      message['content']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Индикатор загрузки
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('AI печатает...'),
                ],
              ),
            ),

          // Поле ввода
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Напишите сообщение...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: 3,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton.small(
                  onPressed: _isLoading ? null : _sendMessage,
                  backgroundColor: const Color(0xFF6C63FF),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
