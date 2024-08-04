import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onTap;
  const ActionButton({
    super.key,
    required this.svgPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: CircleAvatar(
        radius: 15.r,
        backgroundColor: theme.colorScheme.secondary,
        child: SvgPicture.asset(
          svgPath,
          height: 16.r,
          width: 16.r,
        ),
      ),
    );
  }
}
