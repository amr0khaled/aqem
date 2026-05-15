import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSection extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Color color;

  const OnboardingSection({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 40.w,
                spreadRadius: 3.w,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 20.w,
                spreadRadius: 22.w,
              ),
            ],
          ),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: Image.asset(image, width: 35.w, height: 35.w),
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontSize: 36.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: 40.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 15.sp,
            color: const Color(0xFF7A7A7A),
          ),
        ),
      ],
    );
  }
}