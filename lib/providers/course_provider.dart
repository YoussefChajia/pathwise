import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/providers/api_data_provider.dart';
import 'package:pathwise/services/isar_service.dart';

class CourseProvider extends ChangeNotifier {
  final IsarService _isarService = IsarService();
  final ApiDataProvider _apiDataProvider = ApiDataProvider();
  List<Course> _courses = [];
  List<Module> _modules = [];
  List<Lesson> _lessons = [];

  List<Course> get courses => _courses;
  List<Module> get modules => _modules;
  List<Lesson> get lessons => _lessons;

  Future<void> fetchAllCourses() async {
    _courses = await _isarService.getAllCourses();
    notifyListeners();
  }

  Future<void> fetchModulesFor(Course course) async {
    _modules = await _isarService.getModulesFor(course);
    notifyListeners();
  }

  Future<void> fetchLessonsFor(Module module) async {
    _lessons = await _isarService.getLessonsFor(module);
    notifyListeners();
  }

  Future<void> saveCourse(Course course) async {
    await _isarService.saveCourse(course);
    _courses.add(course);
    notifyListeners();
  }

  Future<void> saveModule(Module module) async {
    await _isarService.saveModule(module);
    _modules.add(module);
    notifyListeners();
  }

  Future<void> saveLesson(Lesson lesson) async {
    await _isarService.saveLesson(lesson);
    _lessons.add(lesson);
    notifyListeners();
  }

  Future<void> clearDB() async {
    await _isarService.cleanDb();
    _courses.clear();
    _modules.clear();
    _lessons.clear();
    notifyListeners();
  }

  // ================== Getting Courses from the API ==================

  Future<void> fetchCourseFromAPI(String subject, String userQuizzes) async {
    await _apiDataProvider.fetchAssessmentQuizzes(subject);
    String? courseJson = _apiDataProvider.data;

    if (courseJson != null) {
      final decodedCourse = json.decode(courseJson);
      await _saveCourseFromJson(decodedCourse);
    } else {
      if (kDebugMode) print("No course data received from API");
    }
  }

  Future<void> _saveCourseFromJson(Map<String, dynamic> courseJson) async {
    final course = Course.fromJson(courseJson);
    await _isarService.saveCourse(course);

    for (var moduleJson in courseJson['modules']) {
      final module = Module.fromJson(moduleJson);
      module.course.value = course;
      await _isarService.saveModule(module);

      for (var lessonJson in moduleJson['lessons']) {
        final lesson = Lesson.fromJson(lessonJson);
        lesson.module.value = module;
        await _isarService.saveLesson(lesson);
      }
    }

    await fetchAllCourses();
  }

  // ================== Getters & Setters ==================

  Course getCourse(int courseId) {
    return _courses.firstWhere((course) => course.id == courseId);
  }

  void setProgress(int courseId, double progress) {
    final course = getCourse(courseId);
    course.progress = progress;
    notifyListeners();
  }
}
