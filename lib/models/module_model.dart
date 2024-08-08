import 'package:isar/isar.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/course_model.dart';

part 'module_model.g.dart';

@Collection()
class Module {
  Id id = Isar.autoIncrement;

  late String title;
  late DateTime createdAt;
  double progress = 0.0;
  bool isCompleted = false;
  String? description;
  int? estimatedDuration;
  DateTime? updatedAt;

  final lessons = IsarLinks<Lesson>();

  @Backlink(to: 'modules')
  final course = IsarLink<Course>();

  Module({
    required this.title,
    this.progress = 0.0,
    this.isCompleted = false,
    this.description,
    this.estimatedDuration,
    this.updatedAt,
  }) : createdAt = DateTime.now();

  Module.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        progress = json['progress'],
        isCompleted = json['isCompleted'],
        description = json['description'],
        estimatedDuration = json['estimatedDuration'],
        createdAt = DateTime.now();
}
