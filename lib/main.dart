import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/providers/api_data_provider.dart';
import 'package:pathwise/providers/lesson_provider.dart';
import 'package:pathwise/providers/module_provider.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/screens/assessment_page.dart';
import 'package:pathwise/screens/course_page.dart';
import 'package:pathwise/screens/home_page.dart';
import 'package:pathwise/screens/results_page.dart';
import 'package:pathwise/screens/pre_assessment_page.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/page_transition.dart';
import 'package:provider/provider.dart';

import 'screens/new_subject_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.dark,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiDataProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => ModuleProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathwise - AI Tutor',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.dark,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(
              builder: (context) => const HomePage(),
              settings: settings,
            );
          case '/new-subject':
            return PageTransition(
              builder: (context) => NewSubjectPage(),
              settings: settings,
            );
          case '/pre-assessment':
            return PageTransition(
              builder: (context) => const PreAssessmentPage(),
              settings: settings,
            );
          case '/assessment':
            return PageTransition(
              builder: (context) => const AssessmentPage(),
              settings: settings,
            );
          case '/result':
            return PageTransition(
              builder: (context) => const ResultsPage(),
              settings: settings,
            );
          case '/course':
            final id = settings.arguments as int;
            return PageTransition(
              builder: (context) => CoursePage(courseId: id),
              settings: settings,
            );
          default:
            return PageTransition(
              builder: (context) => const HomePage(),
              settings: settings,
            );
        }
      },
    );
  }
}
