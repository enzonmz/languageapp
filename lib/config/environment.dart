class Environment {
  // Firebase configuration
  static const String firebaseApiKey = String.fromEnvironment(
    'FIREBASE_API_KEY',
    defaultValue: 'YOUR_API_KEY',
  );
  static const String firebaseAppId = String.fromEnvironment(
    'FIREBASE_APP_ID',
    defaultValue: 'YOUR_APP_ID',
  );
  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_SENDER_ID',
    defaultValue: 'YOUR_SENDER_ID',
  );
  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'YOUR_PROJECT_ID',
  );

  // API configuration
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );
  static const String apiVersion = 'v1';

  // Feature flags
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
    defaultValue: true,
  );
  static const bool enableAnalytics = bool.fromEnvironment(
    'ENABLE_ANALYTICS',
    defaultValue: true,
  );
  static const bool enableAuth = bool.fromEnvironment(
    'ENABLE_AUTH',
    defaultValue: true,
  );
  static const bool enableNotifications = bool.fromEnvironment(
    'ENABLE_NOTIFICATIONS',
    defaultValue: true,
  );
}
