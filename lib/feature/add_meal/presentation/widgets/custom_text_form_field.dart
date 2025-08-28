import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.maxLines,
    required this.controller,
    required this.keyboardType,
    required this.validator,
  });
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.gray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.gray, width: 2),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
