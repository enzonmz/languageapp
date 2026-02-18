class NotificationService {
  Future<void> initialize() async {}

  Future<void> scheduleDailyReminder(int hour, int minute) async {
    print('Daily reminder scheduled for $hour:$minute');
  }

  Future<void> scheduleReviewReminder(int hour, int minute) async {
    print('Review reminder scheduled for $hour:$minute');
  }
}
