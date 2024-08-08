import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pathwise/utils/config.dart';
import 'package:pathwise/utils/prompts.dart';

class ApiDataProvider extends ChangeNotifier {
  String? _data;
  final model = GenerativeModel(model: Config.aiModel, apiKey: Config.apiKey);

  String? get data => _data;

  Future<void> fetchAssessmentQuizzes(String subject) async {
    try {
      final content = [Content.text(PromptManager.getAssessmentQuizzes(subject))];
      final response = await model.generateContent(content);
      _data = response.text;
    } catch (e) {
      _data = "Error: ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> fetchAssessmentEvaluation(String subject, String userQuizzes) async {
    try {
      final content = [Content.text(PromptManager.getAssessmentEvaluation(subject, userQuizzes))];
      final response = await model.generateContent(content);
      _data = response.text;
    } catch (e) {
      _data = "Error: ${e.toString()}";
    }
    notifyListeners();
  }

  Future<void> fetchNewCourse(String subject, String userQuizzes) async {
    try {
      final content = [Content.text(PromptManager.getNewCourse(subject, userQuizzes))];
      final response = await model.generateContent(content);
      _data = response.text;
    } catch (e) {
      _data = "Error: ${e.toString()}";
    }
    notifyListeners();
  }
}
