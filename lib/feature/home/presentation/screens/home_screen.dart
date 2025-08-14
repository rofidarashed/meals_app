import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/utils/app_images.dart';
import 'package:meals_app/core/widgets/change_language_button.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';
import 'package:meals_app/feature/home/presentation/widgets/custom_meal_card.dart';
import 'package:meals_app/feature/home/presentation/widgets/home_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 15.w),
            Text('my_meals'.tr()),
            ChangeLanguageButton(context: context),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeSliderWidget(),
          SizedBox(height: 20.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my_meals'.tr(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomMealCard(
                 
                  mealModel: MealModel(
                    title: "meals.breakfast_smoothie".tr(),
                    image: AppImages.smoothie,
                    calories: "calories.350".tr(),
                  ),
                ),
                CustomMealCard(
                  mealModel: MealModel(
                    title: "meals.chicken_salad".tr(),
                    image: AppImages.chickenSalad,
                    calories: "calories.600".tr(),
                  ),
                ),
                CustomMealCard(
                  mealModel: MealModel(
                    image: AppImages.vegetableSoup,
                    title: "meals.vegetable_soup".tr(),
                    calories: "calories.450".tr(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
