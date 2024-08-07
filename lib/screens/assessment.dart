import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:pathwise/components/quiz_card.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Assessment", hasActionButton: false),
        body: FutureBuilder(
          future: quizProvider.fetchQuizzes(quizProvider.subject),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.light,
                backgroundColor: AppColors.darkGrey,
              ));
            } else {
              return SingleChildScrollView(
                child: Consumer<QuizProvider>(
                  builder: (context, quizProvider, child) {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: quizProvider.quizzes.length,
                          itemBuilder: (context, index) {
                            return QuizCard(quizIndex: index);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 32.0),
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
                                  'Finish',
                                  style: AppTextStyles.buttonLight,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/result');
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
