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
