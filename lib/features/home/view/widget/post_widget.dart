import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/common/widgets/circular_text_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularText(
              name: "Prince Vegeta",
              radius: 25.r,
              fontSize: 20.sp,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prince Vegeta",
                  style: textTheme.bodyLarge,
                ),
                Text(
                  "@prince.vegeta",
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "et ea vero quia laudantium autem",
          style: textTheme.headlineSmall,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi",
          style: textTheme.headlineSmall,
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: theme.colorScheme.outline,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Show Comments",
                style: textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  SvgConstants.arrowLeft,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: theme.colorScheme.outline,
        ),
      ],
    );
  }
}
