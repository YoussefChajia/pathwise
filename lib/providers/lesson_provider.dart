import 'package:flutter/foundation.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/services/isar_service.dart';

class LessonProvider extends ChangeNotifier {
  final IsarService _isarService = IsarService();
  List<Lesson> _lessons = [];

  List<Lesson> get lessons => _lessons;

  Future<void> fetchLessonsFor(Module module) async {
    _lessons = await _isarService.getLessonsFor(module);
    notifyListeners();
  }

  Future<void> saveLesson(Lesson lesson) async {
    await _isarService.saveLesson(lesson);
    _lessons.add(lesson);
    notifyListeners();
  }

  Future<void> saveLessonsFromJson(Module module, List<dynamic> lessonsJson) async {
    for (var lessonJson in lessonsJson) {
      final lesson = Lesson.fromJson(lessonJson);
      lesson.module.value = module;
      await _isarService.saveLesson(lesson);
    }
    await fetchLessonsFor(module);
  }

  Lesson getLesson(int lessonId) {
    return _lessons.firstWhere((lesson) => lesson.id == lessonId);
  }

  void setProgress(int lessonId, double progress) {
    final lesson = getLesson(lessonId);
    lesson.progress = progress;
    notifyListeners();
  }
}
