import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';

class CustomMealCard extends StatelessWidget {
  const CustomMealCard({
    super.key,
    // required this.image,
    // required this.title,
    // required this.calories,
    required this.mealModel, 
  });
  // final String image;
  // final String title;
  // final String calories;
  final MealModel mealModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pushNamed(context, '/details',arguments: mealModel),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        color: AppColors.white,

        child: Row(
          children: [
            Container(
              height: 56.h,
              width: 56.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage(mealModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mealModel.title, style: TextStyle(fontSize: 16.sp)),
                Text(
                  mealModel.calories,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
