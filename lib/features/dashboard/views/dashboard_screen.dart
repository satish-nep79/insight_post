import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/features/dashboard/controller/dashscreen_controller.dart';
import 'package:insight_post/features/dashboard/models/custom_bottom_nav_item.dart';
import 'package:insight_post/features/dashboard/views/widgets/custom_bottom_nav_bar.dart';
import 'package:insight_post/features/home/view/home_view.dart';
import 'package:insight_post/features/users/view/users_view.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  static const String route = "/";
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final _screens = <Widget>[
    const HomeView(),
    const UsersView(),
  ];

  final PageController _pageController = PageController();
  late final AnimationController? _controller;
  late final Animation<double>? _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _controller?.forward();
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashScreenController = ref.watch(dashScreenProvider.notifier);
    final currentIndex = ref.watch(dashScreenProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Container(
          padding: EdgeInsets.only(
            top: 30.h,
            bottom: 12.h,
            left: 20.w,
            right: 20.w,
          ),
          color: Theme.of(context).colorScheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                SvgConstants.logo,
                height: 30.h,
                width: 120.w,
                fit: BoxFit.contain,
              ),
              // SvgPicture.asset(
              //   SvgConstants.heart,
              // )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomNavBar(
        currentIndex: currentIndex,
        navBarItems: [
          CustomBottomNavItem(
            svgPath: SvgConstants.home,
            labelText: "Home",
          ),
          CustomBottomNavItem(
            svgPath: SvgConstants.users,
            labelText: "Users",
          )
        ],
        onChange: (int value) {
          dashScreenController.onSelectItem(value);
          _pageController.jumpToPage(value);
          _controller?.forward(from: 0);
        },
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _screens.length,
        itemBuilder: (context, index) => FadeTransition(
          opacity: _animation!,
          child: _screens[index],
        ),
      ),
    );
  }
}
