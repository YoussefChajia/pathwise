import 'package:flutter/foundation.dart';
import '../models/course.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];

  List<Course> get courses => [..._courses];

  void fetchCourses() {
    // In a real app, you'd fetch courses from an API or local database
    // For now, we'll use dummy data
    _courses = [
      Course(
        id: '1',
        title: 'Introduction to Flutter',
        iconUrl: 'assets/images/flutter_course.jpg',
      ),
      Course(
        id: '2',
        title: 'Advanced Dart Programming',
        iconUrl: 'assets/images/dart_course.jpg',
      ),
    ];
    notifyListeners();
  }
}
