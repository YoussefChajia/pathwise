import 'package:flutter/material.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class PreAssessmentPage extends StatelessWidget {
  const PreAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'API Results', hasActionButton: false),
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
                child: SizedBox(
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
                      Navigator.of(context).pushNamed('/assessment');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
