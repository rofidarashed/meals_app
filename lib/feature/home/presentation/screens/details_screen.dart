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
          Text(
            "\t\t\t${mealModel.title}",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
