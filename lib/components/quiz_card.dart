import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pathwise/models/quiz.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:pathwise/providers/quiz_provider.dart';

class QuizCard extends StatelessWidget {
  final int quizIndex;

  const QuizCard({super.key, required this.quizIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        Quiz currentQuiz = quizProvider.quizzes[quizIndex];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.borderRadius),
                    topRight: Radius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(currentQuiz.question, style: AppTextStyles.quizTitle),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppConstants.borderRadius),
                    bottomRight: Radius.circular(AppConstants.borderRadius),
                  ),
                  border: Border.all(color: AppColors.light),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: currentQuiz.options.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      return CheckboxListTile(
                        title: Text(option, style: AppTextStyles.body),
                        value: currentQuiz.userAnswers.contains(index),
                        onChanged: (_) {
                          List<int> updatedAnswers = List.from(currentQuiz.userAnswers);
                          if (updatedAnswers.contains(index)) {
                            updatedAnswers.remove(index);
                          } else {
                            updatedAnswers.add(index);
                          }
                          quizProvider.updateAnswers(quizIndex, updatedAnswers);
                        },
                        activeColor: AppColors.light,
                        checkColor: AppColors.light,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
