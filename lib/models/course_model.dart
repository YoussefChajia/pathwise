import 'package:isar/isar.dart';
import 'package:pathwise/models/module_model.dart';

part 'course_model.g.dart';

@Collection()
class Course {
  Id id = Isar.autoIncrement;

  late String title;
  late int color;
  late DateTime createdAt;
  double progress;
  bool isCompleted;
  String? description;
  int? estimatedDuration;
  DateTime? updatedAt;
  String? imageUrl;

  final modules = IsarLinks<Module>();

  Course({
    required this.title,
    required this.color,
    this.progress = 0.0,
    this.isCompleted = false,
    this.description,
    this.estimatedDuration,
    this.updatedAt,
    this.imageUrl,
  }) : createdAt = DateTime.now();

  Course.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        color = json['color'],
        progress = json['progress'],
        isCompleted = json['isCompleted'],
        description = json['description'],
        estimatedDuration = json['estimatedDuration'],
        createdAt = DateTime.now(),
        imageUrl = json['imageUrl'];
}

/*
{
  "title": "Flutter Development Masterclass",
  "color": 4280391411,
  "progress": 0.0,
  "isCompleted": false,
  "description": "A comprehensive course on Flutter development",
  "estimatedDuration": 3600,
  "imageUrl": "https://example.com/flutter-course.jpg",
  "modules": [
    {
      "title": "Introduction to Flutter",
      "progress": 0.0,
      "isCompleted": false,
      "description": "Learn the basics of Flutter",
      "estimatedDuration": 600,
      "lessons": [
        {
          "title": "What is Flutter?",
          "progress": 0.0,
          "isCompleted": false,
          "description": "An overview of Flutter framework",
          "estimatedDuration": 300
        },
        {
          "title": "Setting up your development environment",
          "progress": 0.0,
          "isCompleted": false,
          "description": "Step-by-step guide to install Flutter SDK",
          "estimatedDuration": 300
        }
      ]
    },
    {
      "title": "Dart Programming Language",
      "progress": 0.0,
      "isCompleted": false,
      "description": "Fundamentals of Dart programming",
      "estimatedDuration": 900,
      "lessons": [
        {
          "title": "Dart Syntax",
          "progress": 0.0,
          "isCompleted": false,
          "description": "Basic syntax and structure of Dart",
          "estimatedDuration": 450
        },
        {
          "title": "Object-Oriented Programming in Dart",
          "progress": 0.0,
          "isCompleted": false,
          "description": "OOP concepts in Dart",
          "estimatedDuration": 450
        }
      ]
    }
  ]
}
*/