import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/components/module_card.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatelessWidget {
  final int courseId;
  const CoursePage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    Course currentCourse = Provider.of<CourseProvider>(context).getCourse(courseId);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: currentCourse.title, hasActionButton: false),
        body: Column(
          children: [
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, courseProvider, child) {
                  List<Module> modules = courseProvider.getCourse(courseId).modules.toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      return ModuleCard(module: modules[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
