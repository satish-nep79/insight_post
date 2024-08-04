import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/common/widgets/circular_text_widget.dart';
import 'package:insight_post/features/home/model/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  const PostWidget({
    super.key,
    required this.post,
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
          post.title ?? "",
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          post.body ?? "",
          style: textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: theme.colorScheme.outline,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(
            //     SvgConstants.heart,
            //   ),
            // ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                SvgConstants.message,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                SvgConstants.share,
              ),
            )
          ],
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
