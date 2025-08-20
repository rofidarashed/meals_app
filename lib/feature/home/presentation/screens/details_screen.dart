import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.mealModel});
  final MealModel mealModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,

        title: Text("meal_details".tr()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(mealModel.image),
            fit: BoxFit.cover,
            height: 218.h,
            width: double.infinity,
          ),
          SizedBox(height: 20.h),
          Text(
            "\t\t\t${mealModel.title.tr()}",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 36.h,
            width: 351.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.primaryColor.withOpacity(0.04),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_filled,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${mealModel.time.tr()} min',
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Icon(Icons.star, color: AppColors.primaryColor, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  mealModel.rate.toString(),
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: Text(
              mealModel.description.tr(),
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
