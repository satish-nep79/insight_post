import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/utils/log_helper.dart';

class GenericBottomSheet {
  static void show(
    BuildContext context, {
    required String title,
    required String subTitle,
    required Widget child,
    bool? isDismissible,
  }) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var size = MediaQuery.of(context).size;
    LogHelper.info(title: "Testring");

    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible ?? true,
      isScrollControlled: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      builder: (context) {
        return Container(
          width: size.width,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          padding: EdgeInsets.only(
            top: 48.h,
            bottom: 48.h+MediaQuery.of(context).viewInsets.bottom,
            left: 20.w,
            right: 20.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurface),
                ),
                SizedBox(
                  height: 40.h,
                ),
                child,
                
              ],
            ),
          ),
        );
      },
    );
  }
}
