import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';

class GenericAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final String title;
  const GenericAppbar({
    super.key,
    this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Center(
        child: Row(
          children: [
            Visibility(
              visible: Navigator.canPop(context),
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => context.pop(),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: theme.colorScheme.surface,
                  child: SvgPicture.asset(
                    SvgConstants.arrowLeft,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: textTheme.headlineMedium,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 80.h);
}
