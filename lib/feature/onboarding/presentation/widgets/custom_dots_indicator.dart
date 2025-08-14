import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/onboarding/data/onboarding_lists.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({super.key, required this.position});
  final double position;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: onboardingTitles.length,
      position: position,

      decorator: DotsDecorator(
        activeColor: AppColors.white,
        color: AppColors.gray,
        size: Size(25.w, 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        activeSize: Size(25.w, 6.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
