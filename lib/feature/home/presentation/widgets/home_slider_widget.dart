import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meals_app/feature/home/data/home_slider_images.dart';

class HomeSliderWidget extends StatelessWidget {
  const HomeSliderWidget({super.key, required this.onPageChanged});

  final Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: homeSliderImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 160.h,
        viewportFraction: 1,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
