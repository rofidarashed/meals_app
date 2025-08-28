import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/widgets/custom_dots_indicator.dart';
import 'package:meals_app/feature/home/data/dp_helper.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';
import 'package:meals_app/feature/home/presentation/widgets/custom_meal_card.dart';
import 'package:meals_app/feature/home/presentation/widgets/home_slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var futureMeals;
  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() {
    setState(() {
      futureMeals = DatabaseHelper.instance.getMeals();
    });
  }

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
            SizedBox(width: 20.w),
            Text('my_meals'.tr()),
            IconButton(
              icon: Icon(Icons.refresh, color: AppColors.primaryColor),
              onPressed: _loadMeals,
            ),
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
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                setState(() {
                  futureMeals = DatabaseHelper.instance.getMeals();
                });
              },
              child: Container(
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
                    Expanded(
                      child: FutureBuilder<List<MealModel>>(
                        future: futureMeals,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No meals found.'));
                          } else if (snapshot.hasData) {
                            final mealsList = snapshot.data!;
                            return ListView.builder(
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: CustomMealCard(
                                    mealModel: mealsList[index],
                                  ),
                                );
                              },
                              itemCount: mealsList.length,
                            );
                          } else {
                            return Center(child: Text('No meals found.'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
