import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/constsnts/image_constants.dart';
import 'package:insight_post/common/widgets/generic_button.dart';

class GenericStatusWidget extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const GenericStatusWidget({
    super.key,
    this.imagePath,
    this.title,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath ?? ImageConstants.state400,
          height: 205.h,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          title ?? "400 Error",
          style: textTheme.headlineSmall,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          message ?? "Oops! The page you’re looking for doesn’t exist.",
          style: textTheme.bodySmall,
        ),
        if (onRetry != null)
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: GenericButton(
              width: 120.w,
              height: 40.h,
              title: "Retry",
              onTap: () {
                onRetry?.call();
              },
            ),
          )
      ],
    );
  }
}
