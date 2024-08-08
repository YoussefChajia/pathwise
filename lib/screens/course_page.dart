import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatelessWidget {
  final int courseId;
  const CoursePage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final CourseProvider courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final Course course = courseProvider.getCourse(courseId);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: course.title, hasActionButton: false),
      ),
    );
  }
}
