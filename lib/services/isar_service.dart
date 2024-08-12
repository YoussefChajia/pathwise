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

  Future<void> setLessonCompletion(int lessonId, bool completed) async {
    final isar = await db;

    // Fetch all necessary data before starting the transaction
    final lesson = await isar.lessons.get(lessonId);
    if (lesson == null) return;

    final module = await isar.modules.get(lesson.module.value?.id ?? -1);
    if (module == null) return;

    final course = await isar.courses.get(module.course.value?.id ?? -1);
    if (course == null) return;

    final moduleLessons = await isar.lessons.filter().module((q) => q.idEqualTo(module.id)).findAll();

    final courseModules = await isar.modules.filter().course((q) => q.idEqualTo(course.id)).findAll();

    // Now perform all updates within a single transaction
    await isar.writeTxn(() async {
      // Update lesson
      lesson.isCompleted = completed;
      lesson.progress = completed ? 1.0 : 0.0;
      lesson.updatedAt = DateTime.now();
      await isar.lessons.put(lesson);

      // Update module
      module.isCompleted = moduleLessons.every((l) => l.id == lessonId ? completed : l.isCompleted);
      module.progress = (moduleLessons.map((l) => l.id == lessonId ? (completed ? 1.0 : 0.0) : l.progress).reduce((a, b) => a + b)) / moduleLessons.length;
      await isar.modules.put(module);

      // Update course
      course.isCompleted = courseModules.every((m) => m.id == module.id ? module.isCompleted : m.isCompleted);
      course.progress = (courseModules.map((m) => m.id == module.id ? module.progress : m.progress).reduce((a, b) => a + b)) / courseModules.length;
      await isar.courses.put(course);
    });
  }
}
