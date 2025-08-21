import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/add_meal/presentation/widgets/custom_text_form_field.dart';

class AddMealScreen extends StatelessWidget {
  AddMealScreen({super.key});

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Icon(Icons.add_box, size: 100.h, color: AppColors.gray),
              // Text(
              //   'Add your meal',
              //   style: TextStyle(fontSize: 24.sp, color: AppColors.gray),
              // ),
              CustomTextFormField(
                label: 'form.meal_name'.tr(),
                hintText: 'form.meal_name'.tr(),
                maxLines: 1,
                controller: mealNameController,
              ),
              CustomTextFormField(
                label: 'form.image_url'.tr(),
                hintText: 'https://www.yourimage.com/abc/def'.tr(),
                maxLines: 2,
                controller: imageUrlController,
              ),
              CustomTextFormField(
                label: 'form.rate'.tr(),
                hintText: '3.5',
                maxLines: 1,
                controller: rateController,
              ),
              CustomTextFormField(
                label: 'form.time'.tr(),
                hintText: '20 - 30',
                maxLines: 1,
                controller: timeController,
              ),
              CustomTextFormField(
                label: 'form.description'.tr(),
                hintText: 'form.description'.tr(),
                maxLines: 3,
                controller: descriptionController,
              ),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {},
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
    );
  }
}
