import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/add_meal/presentation/widgets/custom_text_form_field.dart';
import 'package:meals_app/feature/home/data/dp_helper.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';

class AddMealScreen extends StatelessWidget {
  AddMealScreen({super.key});

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'nav.add_meal'.tr(),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  label: 'form.meal_name'.tr(),
                  hintText: 'form.meal_name'.tr(),
                  maxLines: 1,
                  controller: mealNameController,
                  keyboardType: TextInputType.text,
                  validator: (_) {
                    if (mealNameController.text.isEmpty ||
                        mealNameController.text.length < 3) {
                      return "Meal Name must be at least 3 characters long";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'form.image_url'.tr(),
                  hintText: 'https://www.yourimage.com/abc/def'.tr(),
                  maxLines: 2,
                  controller: imageUrlController,
                  keyboardType: TextInputType.text,
                  validator: (_) {
                    if (imageUrlController.text.isEmpty ||
                        !imageUrlController.text.startsWith('http')) {
                      return "Invalid image URL";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'calories'.tr(),
                  hintText: '250',
                  maxLines: 1,
                  controller: caloriesController,
                  keyboardType: TextInputType.number,
                  validator: (_) {
                    if (caloriesController.text.isEmpty) {
                      return "Calories is required";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'form.rate'.tr(),
                  hintText: '3.5',
                  maxLines: 1,
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  validator: (_) {
                    if (rateController.text.isEmpty) {
                      return "Rate is required";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'form.time'.tr(),
                  hintText: '20 - 30',
                  maxLines: 1,
                  controller: timeController,
                  keyboardType: TextInputType.text,
                  validator: (_) {
                    if (timeController.text.isEmpty) {
                      return "Time is required";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  label: 'form.description'.tr(),
                  hintText: 'form.description'.tr(),
                  maxLines: 3,
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  validator: (_) {
                    if (descriptionController.text.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DatabaseHelper.instance
                            .insertMeal(
                              MealModel(
                                title: mealNameController.text,
                                image: imageUrlController.text,
                                calories:
                                    double.tryParse(caloriesController.text) ??
                                    0.0,
                                rate:
                                    double.tryParse(rateController.text) ?? 0.0,
                                time: timeController.text,
                                description: descriptionController.text,
                              ),
                            )
                            .then((value) {
                              mealNameController.clear();
                              imageUrlController.clear();
                              caloriesController.clear();
                              rateController.clear();
                              timeController.clear();
                              descriptionController.clear();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Success'),
                                    content: Text('Meal added successfully!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(100.r),
                      ),
                    ),
                    child: Text(
                      'form.save'.tr(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
