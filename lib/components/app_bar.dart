import 'package:flutter/material.dart';
import 'package:pathwise/utils/colors.dart';
import 'package:pathwise/utils/constants.dart';
import 'package:pathwise/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasLeadingButton;
  final bool hasActionButton;
  final IconData? leadingIcon;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasLeadingButton = true,
    this.hasActionButton = true,
    this.leadingIcon = Icons.arrow_back,
    this.actionIcon,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          hasLeadingButton
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    color: AppColors.darkGrey,
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(leadingIcon),
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: Text(
              title,
              style: hasLeadingButton ? AppTextStyles.header3 : AppTextStyles.header3,
              textAlign: hasLeadingButton ? TextAlign.center : TextAlign.left,
            ),
          ),
          hasActionButton
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
