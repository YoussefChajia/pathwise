import 'package:flutter/foundation.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/services/isar_service.dart';

class ModuleProvider extends ChangeNotifier {
  final IsarService _isarService = IsarService();
  List<Module> _modules = [];

  List<Module> get modules => _modules;

  Future<void> fetchModulesFor(Course course) async {
    _modules = await _isarService.getModulesFor(course);
    notifyListeners();
  }

  Future<void> saveModule(Module module) async {
    await _isarService.saveModule(module);
    _modules.add(module);
    notifyListeners();
  }

  Future<void> saveModulesFromJson(Course course, List<dynamic> modulesJson) async {
    for (var moduleJson in modulesJson) {
      final module = Module.fromJson(moduleJson);
      module.course.value = course;
      await _isarService.saveModule(module);
    }
    await fetchModulesFor(course);
  }

  Module getModule(int moduleId) {
    return _modules.firstWhere((module) => module.id == moduleId);
  }

  void setProgress(int moduleId, double progress) {
    final module = getModule(moduleId);
    module.progress = progress;
    notifyListeners();
  }
}
