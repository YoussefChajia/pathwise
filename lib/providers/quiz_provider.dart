import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pathwise/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> _quizzes = [];
  int _currentIndex = 0;
  String _subject = '';

  List<Quiz> get quizzes => _quizzes;
  int get currentIndex => _currentIndex;
  String get subject => _subject;

  void setQuizzes(List<Quiz> quizzes) {
    _quizzes = quizzes;
    _currentIndex = 0;
    notifyListeners();
  }

  void setSubject(String subject) {
    _subject = subject;
  }

  void updateAnswers(int quizIndex, List<int> selectedAnswers) {
    if (quizIndex < _quizzes.length) {
      _quizzes[quizIndex].userAnswers = selectedAnswers;
      notifyListeners();
    }
  }

  List<Quiz> parseQuizzes(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Quiz.fromJson(json)).toList();
  }

  String quizzesToJson() {
    List<Map<String, dynamic>> quizzesJson = quizzes.map((quiz) => quiz.toJson()).toList();
    return jsonEncode(quizzesJson);
  }

  double evaluateQuizAnswers(List<Quiz> quizzes) {
    double totalScore = 0;

    for (var quiz in quizzes) {
      List<int> correctAnswers = List<int>.from(quiz.correctAnswers);
      List<int> userAnswers = List<int>.from(quiz.userAnswers);

      correctAnswers.sort();
      userAnswers.sort();

      if (userAnswers.every((answer) => correctAnswers.contains(answer))) {
        // All user answers are correct
        if (userAnswers.length == correctAnswers.length) {
          // User guessed all correct answers
          totalScore += 1;
        } else {
          // User guessed some correct answers, but not all
          totalScore += userAnswers.length / correctAnswers.length;
        }
      }
      // If user guessed any wrong answers or a mix of correct and wrong, they get 0 points (default case)
    }

    return totalScore;
  }
}
