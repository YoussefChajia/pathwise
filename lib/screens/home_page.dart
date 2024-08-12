import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/components/course_card.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/providers/api_data_provider.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _fetchAllCourses();
  }

  Future<void> _fetchAllCourses() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    await courseProvider.fetchAllCourses();
  }

  Future<void> _clearDB() async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    await courseProvider.clearDB();
  }

  Lesson getCurrentLesson(Course course) {
    // Create a set completion function for modules
    Module currentModule = course.modules.firstWhere(
      (module) => !module.isCompleted,
      orElse: () => course.modules.last,
    );

    // print current module
    print('Current Module: ${currentModule.title}');

    // Find the current not completed lesson in the current module
    for (Lesson lesson in currentModule.lessons) {
      if (!lesson.isCompleted) {
        return lesson;
      }
    }

    Module nextModule = course.modules.firstWhere(
      (module) => module.id > currentModule.id,
      orElse: () => currentModule,
    );
    return nextModule.lessons.first;
  }

  Lesson getNextLesson(Course course, Lesson currentLesson) {
    // Get all modules as a list for easier iteration
    List<Module> modules = course.modules.toList();
    int currentModuleIndex = modules.indexWhere((module) => module.id == currentLesson.module.value?.id);

    // Check for next lesson in the current module
    List<Lesson> currentModuleLessons = currentLesson.module.value?.lessons.toList() ?? [];
    int currentLessonIndex = currentModuleLessons.indexWhere((lesson) => lesson.id == currentLesson.id);

    for (int i = currentLessonIndex + 1; i < currentModuleLessons.length; i++) {
      if (!currentModuleLessons[i].isCompleted) {
        return currentModuleLessons[i];
      }
    }

    // Check for lessons in subsequent modules
    for (int i = currentModuleIndex + 1; i < modules.length; i++) {
      Module nextModule = modules[i];
      List<Lesson> nextModuleLessons = nextModule.lessons.toList();
      if (nextModuleLessons.isNotEmpty) {
        Lesson nextLesson = nextModuleLessons.firstWhere(
          (lesson) => !lesson.isCompleted,
          orElse: () => nextModuleLessons.first,
        );
        return nextLesson;
      }
    }

    // If no next lesson found, return the first lesson of the first module
    return modules.first.lessons.first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Hello Francesca', hasLeadingButton: false),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.light,
                        backgroundColor: AppColors.darkGrey,
                      ),
                    );
                  } else {
                    return Consumer<CourseProvider>(
                      builder: (context, courseProvider, child) {
                        return RefreshIndicator(
                          onRefresh: () => courseProvider.fetchAllCourses(),
                          color: AppColors.dark,
                          backgroundColor: AppColors.light,
                          child: courseProvider.courses.isNotEmpty
                              ? ListView.builder(
                                  itemCount: courseProvider.courses.length,
                                  itemBuilder: (context, index) {
                                    final course = courseProvider.courses[index];
                                    final currentLesson = getCurrentLesson(course);
                                    final nextLesson = getNextLesson(course, currentLesson);

                                    return CourseCard(course: courseProvider.courses[index], currentLesson: currentLesson, nextLesson: nextLesson);
                                  },
                                )
                              : LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints) {
                                    return SingleChildScrollView(
                                      physics: const AlwaysScrollableScrollPhysics(),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                                        child: const Center(
                                          child: Text('Pull to refresh!', style: AppTextStyles.caption),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () => _saveGeneratedCourse(),
            //         child: const Text('Generate Course'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () => _clearDB(),
            //         child: const Text('Clear database'),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: 100,
              width: double.infinity,
              color: AppColors.dark,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                backgroundColor: AppColors.light,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'New Subject',
                  style: AppTextStyles.buttonLight,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/new-subject');
              },
            ),
          ),
        ),
      ),
    );
  }
}
