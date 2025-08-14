import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/onboarding/data/onboarding_lists.dart';

class OnboardingDescription extends StatelessWidget {
  const OnboardingDescription({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.h),
        Text(
          onboardingTitles[index].tr(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          onboardingSubTitles[index].tr(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
