import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pathwise/models/quiz_model.dart';
import 'package:pathwise/providers/api_data_provider.dart';

class QuizProvider extends ChangeNotifier {
  final ApiDataProvider _apiDataProvider = ApiDataProvider();

  String _subject = '';
  List<Quiz> _quizzes = [];

  String _evaluation = '';

  Future<void> fetchQuizzes(String subject) async {
    await _apiDataProvider.fetchAssessmentQuizzes(subject);
    String? quizzesJson = _apiDataProvider.data;

    if (quizzesJson != null) {
      try {
        List<dynamic> decodedQuizzes = jsonDecode(quizzesJson);
        _subject = subject;
        _quizzes = decodedQuizzes.map((quizJson) => Quiz.fromJson(quizJson)).toList();
        notifyListeners();
      } catch (e) {
        if (kDebugMode) print("Error decoding quizzes: $e");
      }
    } else {
      if (kDebugMode) print("No quiz data received from API");
    }
  }

  Future<void> fetchEvaluationFromAPI(String? data) async {
    if (data != null) {
      final jsonData = json.decode(data);
      _evaluation = jsonData['evaluation'];
    } else {
      if (kDebugMode) print("No course data received from API");
    }
  }

  List<Quiz> parseQuizzes(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Quiz.fromJson(json)).toList();
  }

  String quizzesToJson() {
    List<Map<String, dynamic>> quizzesJson = _quizzes.map((quiz) => quiz.toJson()).toList();
    return jsonEncode(quizzesJson);
  }

  // ============== Getters & Setters ==============

  List<Quiz> get quizzes => _quizzes;
  String get subject => _subject;
  String get evaluation => _evaluation;

  void setQuizzes(List<Quiz> quizzes) {
    _quizzes = quizzes;
    notifyListeners();
  }

  void setSubject(String subject) {
    _subject = subject;
    notifyListeners();
  }

  void updateAnswers(int quizIndex, List<int> selectedAnswers) {
    if (quizIndex < _quizzes.length) {
      _quizzes[quizIndex].userAnswers = selectedAnswers;
      notifyListeners();
    }
  }

  double getQuizScore(List<Quiz> quizzes) {
    double totalScore = 0;

    for (var quiz in quizzes) {
      List<int> correctAnswers = List<int>.from(quiz.correctAnswers);
      List<int> userAnswers = List<int>.from(quiz.userAnswers);

      correctAnswers.sort();
      userAnswers.sort();

      if (userAnswers.every((answer) => correctAnswers.contains(answer))) {
        if (userAnswers.length == correctAnswers.length) {
          totalScore += 1;
        } else {
          totalScore += userAnswers.length / correctAnswers.length;
        }
      }
    }

    return (totalScore / quizzes.length) * 100;
  }
}
