import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/common/widgets/action_button.dart';
import 'package:insight_post/common/widgets/circular_text_widget.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/utils/url_helper.dart';

class UserRow extends StatelessWidget {
  final User user;
  final int index;
  const UserRow({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Row(
      children: [
        CircularText(
          name: user.name ?? "-",
          radius: 25.r,
          fontSize: 20.sp,
          colorAsIndex: index,
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name ?? "-",
              style: textTheme.bodyLarge,
            ),
            Text(
              "@${user.username}",
              style: textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          ],
        ),
        const Spacer(),
        if (user.website != null)
          ActionButton(
            svgPath: SvgConstants.globe,
            onTap: () => UrlLaunchHelper.website(user.website ?? ""),
          ),
        SizedBox(
          width: 8.w,
        ),
        ActionButton(
          svgPath: SvgConstants.mail,
          onTap: () => UrlLaunchHelper.email(user.email ?? ""),
        ),
        SizedBox(
          width: 8.w,
        ),
        ActionButton(
          svgPath: SvgConstants.phone,
          onTap: () => UrlLaunchHelper.phone(user.phone ?? ""),
        ),
      ],
    );
  }
}
