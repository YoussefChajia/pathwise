import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pathwise/screens/temp_result.dart';
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
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
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
          case '/result':
            return PageTransition(
              builder: (context) => const TempResultPage(),
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
