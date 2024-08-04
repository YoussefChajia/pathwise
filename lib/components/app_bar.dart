import 'package:flutter/material.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasActionButton;
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.hasActionButton,
    this.leadingIcon,
    this.actionIcon,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.darkGrey,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(leadingIcon ?? Icons.arrow_back),
            ),
          ),
          Text(
            title,
            style: AppTextStyles.header3,
          ),
          hasActionButton
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.darkGrey,
                  ),
                  child: IconButton(
                    onPressed: onActionPressed,
                    icon: Icon(actionIcon),
                  ),
                )
              : const SizedBox(width: 50),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.appBarHeight);
}
