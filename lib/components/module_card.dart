import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pathwise/models/lesson_model.dart';
import 'package:pathwise/models/module_model.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class ModuleCard extends StatefulWidget {
  final Module module;

  const ModuleCard({super.key, required this.module});

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  // The whole widget would have to rebuild anyways, so.. no provider
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Lesson> lessons = widget.module.lessons.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppConstants.borderRadius),
                  topRight: const Radius.circular(AppConstants.borderRadius),
                  bottomLeft: _isExpanded ? Radius.zero : const Radius.circular(AppConstants.borderRadius),
                  bottomRight: _isExpanded ? Radius.zero : const Radius.circular(AppConstants.borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.module.title,
                      style: AppTextStyles.quizTitle,
                      softWrap: true,
                    )),
                    Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward, color: AppColors.dark, size: 20.0),
                  ],
                ),
              ),
            ),
          ),
          if (_isExpanded)
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    Lesson lesson = lessons[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 2.0),
                              lesson.isCompleted ? const Icon(Icons.circle, size: 16, color: AppColors.green) : const Icon(Icons.circle_outlined, size: 16, color: AppColors.light),
                              // const SizedBox(height: 2.0),
                              // index != lessons.length - 1 ? Container(height: 16, width: 1, color: AppColors.light) : const SizedBox(),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (kDebugMode) print('Lesson ID: ${lesson.id}');
                            Navigator.pushNamed(context, '/lesson', arguments: lesson);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lesson.title, style: AppTextStyles.body),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
