import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/core/shared/shared_prefs.dart';
import 'package:meals_app/core/utils/app_colors.dart';
import 'package:meals_app/core/utils/app_images.dart';
import 'package:meals_app/core/utils/app_strings.dart';
import 'package:meals_app/core/widgets/change_language_button.dart';
import 'package:meals_app/feature/onboarding/data/onboarding_lists.dart';
import 'package:meals_app/core/widgets/custom_dots_indicator.dart';
import 'package:meals_app/feature/onboarding/presentation/widgets/onboarding_buttons.dart';
import 'package:meals_app/feature/onboarding/presentation/widgets/onboarding_description.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  CarouselSliderController carouselController = CarouselSliderController();
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ChangeLanguageButton(context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.onboarding,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 370.h,
            child: Container(
              height: 400.h,
              width: 311.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: 250.0,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          position = index;
                        });
                      },
                    ),
                    items: List.generate(onboardingTitles.length, (index) {
                      return OnboardingDescription(index: index);
                    }),
                  ),
                  CustomDotsIndicator(position: position.toDouble()),
                  SizedBox(height: 45.h),
                  OnboardingButtons(
                    onGetStarted: () {
                      SharedPrefs.setBool(
                        key: AppStrings.isOnboardingKey,
                        value: true,
                      );
                      debugPrint(
                        SharedPrefs.getBool(
                          key: AppStrings.isOnboardingKey,
                        ).toString(),
                      );

                      Navigator.pushReplacementNamed(context, '/layout');
                    },
                    onSkip: () {
                      SharedPrefs.setBool(
                        key: AppStrings.isOnboardingKey,
                        value: true,
                      );
                      debugPrint(
                        SharedPrefs.getBool(
                          key: AppStrings.isOnboardingKey,
                        ).toString(),
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    onNext: () => carouselController.nextPage(),
                    position: position,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
