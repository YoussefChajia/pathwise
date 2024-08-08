import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [CourseSchema, ModuleSchema, LessonSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> saveCourse(Course newCourse) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.courses.putSync(newCourse));
  }

  Future<void> saveModule(Module newModule) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.modules.putSync(newModule));
  }

  Future<void> saveLesson(Lesson newLesson) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.lessons.putSync(newLesson));
  }

  Future<List<Course>> getAllCourses() async {
    final isar = await db;
    return await isar.courses.where().findAll();
  }

  Future<List<Module>> getModulesFor(Course course) async {
    final isar = await db;
    return await isar.modules.filter().course((q) => q.idEqualTo(course.id)).findAll();
  }

  Future<List<Lesson>> getLessonsFor(Module module) async {
    final isar = await db;
    return await isar.lessons.filter().module((q) => q.idEqualTo(module.id)).findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
