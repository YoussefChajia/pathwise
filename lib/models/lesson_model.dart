import 'package:isar/isar.dart';
import 'package:pathwise/models/module_model.dart';

part 'lesson_model.g.dart';

@Collection()
class Lesson {
  Id id = Isar.autoIncrement;

  late String title;
  late DateTime createdAt;
  double progress = 0.0;
  bool isCompleted = false;
  String? description;
  int? estimatedDuration;
  DateTime? updatedAt;

  @Backlink(to: 'lessons')
  final module = IsarLink<Module>();

  Lesson({
    required this.title,
    this.progress = 0.0,
    this.isCompleted = false,
    this.description,
    this.estimatedDuration,
    this.updatedAt,
  }) : createdAt = DateTime.now();

  Lesson.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        progress = json['progress'],
        isCompleted = json['isCompleted'],
        description = json['description'],
        estimatedDuration = json['estimatedDuration'],
        createdAt = DateTime.now();
}
