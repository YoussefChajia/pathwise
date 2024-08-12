import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class AppMarkdownStyleSheet {
  static MarkdownStyleSheet get darkTheme => MarkdownStyleSheet(
        h1: AppTextStyles.header1,
        h2: AppTextStyles.header2,
        h3: AppTextStyles.header3,
        p: AppTextStyles.body,
        strong: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
        em: const TextStyle(fontStyle: FontStyle.italic),
        a: const TextStyle(color: AppColors.purpleCard),
        tableHead: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
        tableBody: AppTextStyles.body,
        code: const TextStyle(
          fontFamily: 'Courier',
          fontSize: 14.0,
          color: AppColors.light,
          backgroundColor: AppColors.darkGrey,
        ),
        codeblockDecoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        blockquote: AppTextStyles.body.copyWith(
          color: AppColors.lightGrey,
          fontStyle: FontStyle.italic,
        ),
        listBullet: AppTextStyles.body.copyWith(color: AppColors.light),
        img: const TextStyle(
          fontStyle: FontStyle.italic,
          color: AppColors.lightGrey,
        ),
        horizontalRuleDecoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: AppColors.lightGrey,
            ),
          ),
        ),
      );
}
