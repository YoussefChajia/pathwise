import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:pathwise/models/quiz.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:pathwise/providers/api_data.dart';

class PreAssessmentPage extends StatelessWidget {
  final String subject;

  const PreAssessmentPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    Provider.of<QuizProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'API Results', hasActionButton: false, leadingIcon: Icons.arrow_back),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Before we start your learning journey, we need to understand your current knowledge level.\n', style: AppTextStyles.body),
                    Text('Your answers help us customize the content to match your current skill level, making your learning experience more effective.\n',
                        style: AppTextStyles.body),
                    Text(
                        'Resist the urge to look up answers—this is about assessing your true understanding. The more accurately we can gauge your current knowledge, the better we can support your learning journey.\n',
                        style: AppTextStyles.body),
                    Text('Take your time and focus on what you know. This is all about your improvement!\n', style: AppTextStyles.body),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: FutureBuilder(
                  future: Provider.of<ApiDataProvider>(context, listen: false).fetchAssessmentQuizzes(subject),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Consumer<ApiDataProvider>(
                        builder: (context, apiDataProvider, child) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                                backgroundColor: AppColors.light,
                              ),
                              child: const Text(
                                'Continue',
                                style: AppTextStyles.buttonLight,
                              ),
                              onPressed: () {
                                final quizProvider = Provider.of<QuizProvider>(context, listen: false);
                                // Get the quizzes from the API data as JSON
                                List<Quiz> quizzes = quizProvider.parseQuizzes(apiDataProvider.data ?? '[{}]');
                                quizProvider.setQuizzes(quizzes);
                                quizProvider.setSubject(subject);
                                Navigator.of(context).pushNamed('/assessment');
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
