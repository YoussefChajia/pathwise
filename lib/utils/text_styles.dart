import 'package:flutter/material.dart';
import 'colors.dart'; // Import colors if needed

class AppTextStyles {
  // Heading Styles
  static const TextStyle header1 = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    color: AppColors.light,
  );

  static const TextStyle header2 = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: AppColors.light,
  );

  static const TextStyle header3 = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.light,
  );

  // Body Text Style
  static const TextStyle body = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: AppColors.light,
  );

  // Caption Style
  static const TextStyle caption = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: AppColors.lightGrey,
  );

  // Quiz question style
  static const TextStyle quizTitle = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  // Button Text Style
  static const TextStyle buttonLight = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
  );

  static const TextStyle buttonDark = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18.0,
    fontWeight: FontWeight.w300,
    color: AppColors.dark,
  );

  // Hint Text Style
  static const TextStyle hint = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: AppColors.lightGrey,
  );
}
