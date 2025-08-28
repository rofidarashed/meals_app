import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/widgets/flexible_image.dart';
import 'package:meals_app/feature/home/data/dp_helper.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';

class CustomMealCard extends StatefulWidget {
  const CustomMealCard({super.key, required this.mealModel});
  final MealModel mealModel;

  @override
  State<CustomMealCard> createState() => _CustomMealCardState();
}

class _CustomMealCardState extends State<CustomMealCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/details', arguments: widget.mealModel),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        color: AppColors.white,

        child: Row(
          children: [
            FlexibleImage(
              image: widget.mealModel.image,
              height: 80.h,
              width: 100.w,
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mealModel.title.tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  '${widget.mealModel.calories} ${'calories'.tr()}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                DatabaseHelper.instance.deleteMeal(widget.mealModel.id!);
                setState(() {
                  DatabaseHelper.instance.getMeals();
                });
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
