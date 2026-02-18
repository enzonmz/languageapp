import 'package:flutter/material.dart';
import 'app.dart';
import 'data/local/local_database.dart';
import 'data/remote/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация локальной базы данных
  await LocalDatabase().init();

  // Инициализация Supabase
  await SupabaseService.initialize();

  runApp(const LanguageLearningApp());
}
