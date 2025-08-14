import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    super.key,
    required this.position,
    required this.onSkip,
    required this.onNext,
    required this.onGetStarted,
  });
  final int position;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    if (position == 2) {
      return CircleAvatar(
        radius: 31.r,
        backgroundColor: AppColors.white,
        child: IconButton(
          onPressed: onGetStarted,
          icon: Icon(Icons.arrow_forward, color: AppColors.primaryColor),
        ),
      );
    } else {
      return Row(
        children: [
          TextButton(
            onPressed: onSkip,
            child: Text(
              'intro.skip'.tr(),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: onNext,
            child: Text(
              'intro.next'.tr(),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }
  }
}
