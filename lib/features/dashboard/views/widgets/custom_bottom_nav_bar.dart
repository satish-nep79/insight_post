import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/app_time_values.dart';
import 'package:insight_post/features/dashboard/models/custom_bottom_nav_item.dart';
import 'package:insight_post/features/dashboard/models/selected_bottom_nav_item_notification.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int value) onChange;
  final int currentIndex;
  final List<CustomBottomNavItem> navBarItems;
  const CustomBottomNavBar(
      {super.key,
      required this.onChange,
      required this.currentIndex,
      required this.navBarItems});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: NotificationListener<SelectedBottomNavItemNotification>(
        onNotification: (data) {
          onChange(data.index);
          return true;
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: navBarItems.asMap().entries.map(
            (e) {
              var item = e.value;
              return CustomBottomNavbarItem(
                svgPath: item.svgPath,
                labelText: item.labelText,
                selectedIndex: currentIndex,
                index: e.key,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class CustomBottomNavbarItem extends StatelessWidget {
  final String svgPath;
  final String labelText;
  final int index;
  final int selectedIndex;
  const CustomBottomNavbarItem({
    super.key,
    required this.svgPath,
    required this.labelText,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => SelectedBottomNavItemNotification(index).dispatch(context),
      child: AnimatedContainer(
        duration: AppTimeValues.defaultBottomNav,
        decoration: BoxDecoration(
          color: index == selectedIndex
              ? theme.colorScheme.secondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 7.h,
          horizontal: 14.w,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
            ),
            AnimatedCrossFade(
              firstChild: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  labelText,
                  style: textTheme.bodySmall,
                ),
              ),
              secondChild: const SizedBox(),
              crossFadeState: selectedIndex == index
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: AppTimeValues.defaultBottomNav,
            )
          ],
        ),
      ),
    );
  }
}
