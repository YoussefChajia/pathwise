import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/components/quiz_card.dart';
import 'package:pathwise/providers/quiz_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  late Future<void> _quizzesFuture;

  @override
  void initState() {
    super.initState();
    _quizzesFuture = _fetchQuizzes();
  }

  Future<void> _fetchQuizzes() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    await quizProvider.fetchQuizzes(quizProvider.subject);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Assessment", hasActionButton: false),
        body: FutureBuilder(
          future: _quizzesFuture,
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
