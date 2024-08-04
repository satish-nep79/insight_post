import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/constsnts/app_colors.dart';

class CircularText extends StatelessWidget {
  final String name;
  final double? radius;
  final double? fontSize;

  final int? colorAsIndex;

  static final backgroundColorList = [
    AppColors.roundedRedBackground,
    AppColors.roundedBlueBackground,
    AppColors.roundedPurpleBackground,
    AppColors.roundedGreyBackground,
    AppColors.roundedGreenBackground,
  ];
  static final textColorList = [
    AppColors.roundedRedText,
    AppColors.roundedBlueText,
    AppColors.roundedPurpleText,
    AppColors.roundedGreyText,
    AppColors.roundedGreenText,
  ];

  const CircularText({
    super.key,
    required this.name,
    this.radius,
    this.fontSize,
    this.colorAsIndex,
  });

  @override
  Widget build(BuildContext context) {
    final radius = this.radius ?? 20.r;

    final colorAsIndex = (this.colorAsIndex??0) %5;
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: colorAsIndex != null
            ? backgroundColorList
                .elementAtOrNull(colorAsIndex % backgroundColorList.length)
            : Colors.grey.shade100,
        radius: radius,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Center(
            child: Text(
              firstTwoName,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: colorAsIndex != null
                    ? textColorList
                        .elementAtOrNull(colorAsIndex % textColorList.length)
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String get firstTwoName {
    const placeHolder = "-";
    try {
      final words = name.split(" ")..removeWhere((e) => e.isEmpty);
      if (words.length > 1) {
        return words[0].trim()[0] + words[1].trim()[0];
      } else if (words.length == 1) {
        return words[0][0];
      }
    } catch (e, _) {}
    return placeHolder;
  }
}
