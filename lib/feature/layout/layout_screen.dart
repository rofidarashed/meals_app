import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/feature/home/presentation/screens/home_screen.dart';
import 'package:meals_app/feature/add_meal/presentation/screens/add_meal_screen.dart';
import 'package:meals_app/feature/profile/presentation/screens/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;
  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = [
    HomeScreen(),
    AddMealScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.gray,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'nav.home'.tr()),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'nav.add_meal'.tr(),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'nav.profile'.tr()),
          ],
        ),
      ),
    );
  }
}
