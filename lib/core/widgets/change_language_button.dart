import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/core/utils/app_colors.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key, required this.context});

  final BuildContext context;
  void changeLanguage() {
    if (context.locale == Locale('en')) {
      context.setLocale(Locale('ar'));
    } else {
      context.setLocale(Locale('en'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: changeLanguage,
      icon: Icon(Icons.language, color: AppColors.black, size: 30),
    );
  }
}
