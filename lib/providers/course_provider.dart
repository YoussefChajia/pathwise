import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/services/isar_service.dart';

class CourseProvider extends ChangeNotifier {
  final IsarService _isarService = IsarService();

  List<Course> _courses = [];

  Future<void> fetchAllCourses() async {
    _courses = await _isarService.getAllCourses();
    notifyListeners();
  }

  Future<void> addCourseFromAPI(String? data) async {
    if (data != null) {
      final cleanData = cleanJsonString(data);
      final jsonData = customJsonDecode(cleanData);

      if (kDebugMode) print(cleanData);

      final course = Course.fromJson(jsonData);
      await _isarService.saveCourse(course);

      for (var moduleJson in jsonData['modules']) {
        final module = Module.fromJson(moduleJson);
        module.course.value = course;

        await _isarService.saveModule(module);

        for (var lessonJson in moduleJson['lessons']) {
          final lesson = Lesson.fromJson(lessonJson);
          lesson.module.value = module;

          await _isarService.saveLesson(lesson);
        }
      }
    } else {
      if (kDebugMode) print("No course data received from API");
    }
  }

  Map<String, dynamic> customJsonDecode(String input) {
    // final regex = RegExp(r'"content":\s*"(.*?)"', dotAll: true);
    final regex = RegExp(r'"content":\s*"([\s\S]*?)"(?=\s*[,}])', multiLine: true);
    final escapedInput = input.replaceAllMapped(regex, (match) {
      String content = match.group(1)!;
      content = content.replaceAll(r'\', r'\\'); // Escape backslashes
      content = content.replaceAll('"', r'\"'); // Escape double quotes
      content = content.replaceAll('\n', r'\n'); // Escape newlines
      return '"content": "$content"';
    });

    // Now use the standard JSON decoder
    return json.decode(escapedInput) as Map<String, dynamic>;
  }

  String cleanJsonString(String rawJson) {
    // Remove leading whitespace
    String trimmed = rawJson.trimLeft();

    // Check if the string starts with ```json
    if (trimmed.startsWith('```json')) {
      trimmed = trimmed.substring(7);
    } else if (trimmed.startsWith('```')) {
      // If it just starts with ```, remove that
      trimmed = trimmed.substring(3);
    }

    // Remove trailing whitespace
    trimmed = trimmed.trimRight();

    // Check if the string ends with ```
    if (trimmed.endsWith('```')) {
      trimmed = trimmed.substring(0, trimmed.length - 3);
    }

    // Trim any remaining whitespace
    return trimmed.trim();
  }

  Future<void> clearDB() async {
    await _isarService.cleanDb();
    _courses.clear();
    notifyListeners();
  }

  // ============== Getters & Setters ==============

  List<Course> get courses => _courses;

  Course getCourse(int courseId) {
    return _courses.firstWhere((course) => course.id == courseId);
  }

  void toggleLessonCompletion(int lessonId, bool status) {
    _isarService.setLessonCompletion(lessonId, status);
    notifyListeners();
  }
}


// {
//   "evaluation": "You have a good grasp of the basics of Flutter development. However, you need to work on your understanding of Dart programming language, and some advanced Flutter concepts, and best practices. We will focus on these areas to improve your skills further.",
//   "title": "Flutter Development",
//   "color": 4280391411,
//   "progress": 0.0,
//   "isCompleted": false,
//   "description": "A comprehensive course on Flutter development",
//   "estimatedDuration": 3600,
//   "modules": [
//     {
//       "title": "Introduction to Flutter",
//       "description": "Learn the basics of Flutter",
//       "progress": 0.0,
//       "isCompleted": false,
//       "estimatedDuration": 600,
//       "lessons": [
//         {
//           "title": "What is Flutter?",
//           "description": "An overview of Flutter framework",
//           "content": "The content of the course in markdown format goes here.",
//           "progress": 0.0,
//           "isCompleted": false,
//           "estimatedDuration": 300
//         },
//         {
//           "title": "Setting up your development environment",
//           "description": "Step-by-step guide to install Flutter SDK",
//           "content": "The content of the course in markdown format goes here.",
//           "progress": 0.0,
//           "isCompleted": false,
//           "estimatedDuration": 300
//         }
//         ...
//       ]
//     },
//     {
//       "title": "Dart Programming Language",
//       "progress": 0.0,
//       "isCompleted": false,
//       "description": "Fundamentals of Dart programming",
//       "estimatedDuration": 900,
//       "lessons": [
//         {
//           "title": "Dart Syntax",
//           "description": "Basic syntax and structure of Dart",
//           "content": "The content of the course in markdown format goes here.",
//           "progress": 0.0,
//           "isCompleted": false,
//           "estimatedDuration": 450
//         },
//         {
//           "title": "Object-Oriented Programming in Dart",
//           "description": "OOP concepts in Dart",
//           "content": "The content of the course in markdown format goes here.",
//           "progress": 0.0,
//           "isCompleted": false,
//           "estimatedDuration": 450
//         }
//         ...
//       ]
//     }
//     ...
//   ]
// }
// ''';