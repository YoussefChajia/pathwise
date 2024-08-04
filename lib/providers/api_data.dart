import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pathwise/utils/config.dart';

class ApiDataProvider extends ChangeNotifier {
  String? _data;

  String? get data => _data;

  Future<void> fetchData(String argument) async {
    try {
      const apiKey = Config.apiKey;
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text('Explain $argument in 20 words or less.')];
      final response = await model.generateContent(content);
      _data = response.text;
    } catch (e) {
      _data = "Error: ${e.toString()}";
    }
    notifyListeners();
  }
}
