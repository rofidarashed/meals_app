import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_box, size: 100.h, color: AppColors.gray),
            Text(
              'Add your meal',
              style: TextStyle(fontSize: 24.sp, color: AppColors.gray),
            ),
          ],
        ),
      ),
    );
  }
}
