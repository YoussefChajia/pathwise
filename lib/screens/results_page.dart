import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/providers/api_data_provider.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<void> _apiDataFuture;

  @override
  void initState() {
    super.initState();
    _apiDataFuture = _fetchAndProcessData();
  }

  Future<void> _fetchAndProcessData() async {
    try {
      await _fetchGeneratedCourse();
      await _saveGeneratedCourse();
      await _saveQuizEvaluation();
    } catch (e) {
      if (kDebugMode) print('Error in _fetchAndProcessData: $e');
    }
  }

  Future<void> _fetchGeneratedCourse() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final apiProvider = Provider.of<ApiDataProvider>(context, listen: false);

    await apiProvider.fetchGeneratedCourse(quizProvider.subject, quizProvider.quizzesToJson());
  }

  Future<void> _saveGeneratedCourse() async {
    final apiProvider = Provider.of<ApiDataProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    await courseProvider.addCourseFromAPI(apiProvider.data);
  }

  Future<void> _saveQuizEvaluation() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final apiProvider = Provider.of<ApiDataProvider>(context, listen: false);

    await quizProvider.fetchEvaluationFromAPI(apiProvider.data);
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final double score = quizProvider.getQuizScore(quizProvider.quizzes);

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Results", hasActionButton: false),
        body: FutureBuilder(
          future: _apiDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.light,
                backgroundColor: AppColors.darkGrey,
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: score / 100,
                            strokeWidth: 10.0,
                            backgroundColor: AppColors.darkGrey,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.light),
                          ),
                        ),
                        Text(
                          '${score.toStringAsFixed(0)} %',
                          style: AppTextStyles.header1,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Consumer<ApiDataProvider>(
                        builder: (context, apiDataProvider, child) {
                          return Column(
                            children: [
                              Text(quizProvider.evaluation, style: AppTextStyles.body),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                          backgroundColor: AppColors.light,
                        ),
                        child: const Text(
                          'Start Learning',
                          style: AppTextStyles.buttonLight,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
