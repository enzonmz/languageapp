class ProgressRepository {
  Future<void> saveProgress(String userId, Map<String, dynamic> data) async {}
  Future<Map<String, dynamic>?> getProgress(String userId) async {
    return null;
  }

  Future<void> recordExerciseResult(
      String userId, bool isCorrect, String wordId) async {}
}
