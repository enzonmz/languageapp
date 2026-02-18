class AnalyticsService {
  void logEvent(String name, Map<String, dynamic> parameters) {
    print('Analytics: $name - $parameters');
  }
}
