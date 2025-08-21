import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/widgets/change_language_button.dart';
import 'package:meals_app/core/widgets/custom_dots_indicator.dart';
import 'package:meals_app/feature/home/data/meals_list.dart';
import 'package:meals_app/feature/home/presentation/widgets/custom_meal_card.dart';
import 'package:meals_app/feature/home/presentation/widgets/home_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int position = 0;
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
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              HomeSliderWidget(
                onPageChanged: (index, reason) {
                  setState(() {
                    position = index;
                  });
                },
              ),
              CustomDotsIndicator(position: position.toDouble()),
            ],
          ),
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
                ListView.builder(
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: CustomMealCard(mealModel: mealsList[index]),
                    );
                  },
                  itemCount: mealsList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
