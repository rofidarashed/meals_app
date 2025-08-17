import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meals_app/core/shared/shared_prefs.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/utils/app_strings.dart';
import 'package:meals_app/feature/add_meal/presentation/screens/layout_screen.dart';
import 'package:meals_app/feature/onboarding/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkOnboarding();
  }

  Future<void> checkOnboarding() async {
    await SharedPrefs.init();
    final isOnboarding =
        SharedPrefs.getBool(key: AppStrings.isOnboardingKey) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return isOnboarding
                ? const LayoutScreen()
                : const OnboardingScreen();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Lottie.asset('assets/animations/Burger.json')),
    );
  }
}
