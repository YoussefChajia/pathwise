import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pathwise/utils/config.dart';
import 'package:pathwise/utils/prompts.dart';

class ApiDataProvider extends ChangeNotifier {
  String? _data;
  final model = GenerativeModel(model: Config.aiModel, apiKey: Config.apiKey);

  String? get data => _data;

  Future<void> fetchAssessmentQuizzes(String argument) async {
    try {
      // final content = [Content.text(PromptManager.getAssessmentQuizzes(argument))];
      // final response = await model.generateContent(content);
      // _data = response.text;
      await Future.delayed(const Duration(seconds: 2));
      _data = '''
[
{
"question": "Which of the following is NOT a valid Java keyword?",
"options": ["class", "interface", "private", "public", "function"],
"correctAnswers": [4],
"userAnswers": []
},
{
"question": "Which of the following statements are true about Java's String class?",
"options": ["Strings are mutable objects.", "Strings are immutable objects.", "String literals are stored in the string pool.", "The equals() method compares string content, while == compares object references.", "Strings can be created using the new keyword or by using string literals."],
"correctAnswers": [1, 2, 3, 4],
"userAnswers": []
},
{
"question": "What is the difference between finally and finalize in Java?",
"options": ["finally is used for exception handling, while finalize is used for garbage collection.", "finalize is used for exception handling, while finally is used for garbage collection.", "finally block executes regardless of whether an exception is thrown or not, while finalize is called by the garbage collector before an object is destroyed.", "finally block is executed only if an exception is thrown, while finalize is called by the garbage collector before an object is destroyed.", "finally and finalize are essentially the same, both used for exception handling."],
"correctAnswers": [2],
"userAnswers": []
}
]
''';
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
}
