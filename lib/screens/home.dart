import 'package:flutter/material.dart';
import 'package:pathwise/components/app_bar.dart';
import 'package:pathwise/components/course_card.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Hello Francesca', hasLeadingButton: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<CourseProvider>(
                builder: (context, courseProvider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courseProvider.courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: courseProvider.courses[index]);
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
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
                        'New Subject',
                        style: AppTextStyles.buttonLight,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/new-subject');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
