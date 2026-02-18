class SrsUseCase {
  // SM-2 algorithm - calculate next review interval
  // quality: 0-5 (0=blackout, 5=perfect)
  // returns next interval in minutes
  int calculateNextInterval(
      int currentInterval, double easeFactor, int quality) {
    if (quality < 3) {
      return 1; // Repeat today
    }

    double newEaseFactor =
        easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (newEaseFactor < 1.3) newEaseFactor = 1.3;

    int newInterval;
    if (currentInterval == 0) {
      newInterval = 1;
    } else if (currentInterval == 1) {
      newInterval = 6;
    } else {
      newInterval = (currentInterval * newEaseFactor).round();
    }

    return newInterval;
  }

  Future<void> processReview(String wordId, bool isCorrect) async {
    // Simplified SRS logic
    print('Word $wordId reviewed, correct: $isCorrect');
  }
}
