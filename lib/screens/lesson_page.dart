import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pathwise/components/custom_app_bar.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/providers/course_provider.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/markdown_styles.dart';
import 'package:pathwise/utils/text_styles.dart';
import 'package:provider/provider.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: widget.lesson.title, actionIcon: Icons.live_help_outlined),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: [
            Text(widget.lesson.description ?? '', style: AppTextStyles.body),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MarkdownBody(
                data: widget.lesson.content,
                selectable: true,
                styleSheet: AppMarkdownStyleSheet.darkTheme,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                    backgroundColor: AppColors.light,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          color: widget.lesson.isCompleted ? AppColors.dark : AppColors.light,
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          border: Border.all(color: AppColors.dark, width: 2.0),
                        ),
                        child: widget.lesson.isCompleted ? const Icon(Icons.check, color: AppColors.light, size: 20.0) : const SizedBox(),
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        'Mark Lesson Complete',
                        style: AppTextStyles.buttonLight,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      widget.lesson.isCompleted = !widget.lesson.isCompleted;
                    });
                    courseProvider.toggleLessonCompletion(widget.lesson.id, widget.lesson.isCompleted);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
