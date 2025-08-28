import 'package:flutter/material.dart';
import 'package:meals_app/feature/home/data/models/meal_model.dart';
import 'package:meals_app/feature/home/presentation/screens/details_screen.dart';
import 'package:meals_app/feature/home/presentation/screens/home_screen.dart';
import 'package:meals_app/feature/layout/layout_screen.dart';
import 'package:meals_app/feature/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:meals_app/feature/onboarding/presentation/screens/splash_screen.dart';
import 'package:meals_app/feature/profile/presentation/screens/profile_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreen(),
  '/layout': (context) => const LayoutScreen(),
  '/home': (context) => const HomeScreen(),
  '/details': (context) => DetailsScreen(mealModel: ModalRoute.of(context)!.settings.arguments as MealModel),
  '/onboarding': (context) => const OnboardingScreen(),
  '/profile': (context) => const ProfileScreen(),
};
