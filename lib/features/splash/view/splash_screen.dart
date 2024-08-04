import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/app_time_values.dart';
import 'package:insight_post/common/constsnts/image_constants.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/common/widgets/generic_bottom_sheet.dart';
import 'package:insight_post/features/splash/view/setup_email_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  _startTimer() {
    Future.delayed(
      AppTimeValues.defaultSplashTime,
      () {
        setUpEmail();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              SvgConstants.logo,
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Powered By",
                  style: textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Image.asset(
                  ImageConstants.techJarLogo,
                  height: 32.r,
                  width: 32.r,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  setUpEmail() {
    GenericBottomSheet.show(
      context,
      title: "Set Up Your Email",
      subTitle: "Set Your Email for Commenting",
      isDismissible: false,
      child: const EmailSetupScreen(),
    );
  }
}
