import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pathwise/models/course_model.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) print('Course ID: ${course.id}');
        Navigator.pushNamed(context, '/course', arguments: course.id);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: Color(course.color),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: AppTextStyles.header3,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.circle_outlined, size: 8, color: Colors.white),
                        Container(height: 20, width: 1, color: Colors.white),
                        const Icon(Icons.circle_outlined, size: 8, color: Colors.white),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Lesson: Control Flow',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Next Lesson: Loops',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius * 5),
                            border: Border.all(color: AppColors.light, width: 2),
                          ),
                        ),
                        Text(
                          '${course.progress.toStringAsFixed(0)} %',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: course.progress < 45 ? AppColors.light : Colors.transparent,
                          ),
                        )
                      ],
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final progressWidth = constraints.maxWidth * (course.progress / 100);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 25,
                              width: progressWidth,
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(AppConstants.borderRadius * 5),
                              ),
                            ),
                            // Progress text
                            Text(
                              '${course.progress.toStringAsFixed(0)} %',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: course.progress >= 45 ? Color(course.color) : Colors.transparent,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
