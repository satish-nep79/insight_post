import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.name ?? "",
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          comment.body ?? "",
          style: textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.left,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "By:- ${comment.email ?? "-"}",
            style: textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 8.h,
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
