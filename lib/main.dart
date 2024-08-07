import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathwise/providers/api_data.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/screens/assessment.dart';
import 'package:pathwise/screens/results.dart';
import 'package:pathwise/screens/pre_assessment.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/page_transition.dart';
import 'package:provider/provider.dart';

import 'screens/homepage.dart';

void main() {
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
              builder: (context) => HomePage(),
              settings: settings,
            );
          case '/pre-assessment':
            final subject = settings.arguments as String;
            return PageTransition(
              builder: (context) => PreAssessmentPage(subject: subject),
              settings: settings,
            );
          case '/assessment':
            return PageTransition(
              builder: (context) => const AssessmentPage(),
              settings: settings,
            );
          case '/result':
            final json = settings.arguments as String;
            return PageTransition(
              builder: (context) => ResultsPage(quizzesJson: json),
              settings: settings,
            );
          default:
            return PageTransition(
              builder: (context) => HomePage(),
              settings: settings,
            );
        }
      },
    );
  }
}
