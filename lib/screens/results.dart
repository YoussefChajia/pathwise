import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:pathwise/providers/api_data.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final apiProvider = Provider.of<ApiDataProvider>(context, listen: false);

    final double score = quizProvider.evaluateQuizAnswers(quizProvider.quizzes);
    final int totalQuestions = quizProvider.quizzes.length;
    final double percentage = (score / totalQuestions) * 100;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Results", hasActionButton: false),
        body: FutureBuilder(
          future: apiProvider.fetchAssessmentEvaluation(quizProvider.subject, quizProvider.quizzesToJson()),
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
                            value: percentage / 100,
                            strokeWidth: 10.0,
                            backgroundColor: AppColors.darkGrey,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.light),
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(0)} %',
                          style: AppTextStyles.header1,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Consumer<ApiDataProvider>(
                        builder: (context, apiDataProvider, child) {
                          return Center(child: Text('${apiDataProvider.data}', style: AppTextStyles.body));
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
