import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/constsnts/app_theme.dart';
import 'package:insight_post/common/constsnts/size_constants.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: SizeConstants.screenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child ?? const SizedBox(),
      child: Consumer(
        builder: (context, ref, _) => MaterialApp.router(
          builder: (context, child) => child ?? const SizedBox(),
          title: "Insight Post",
          theme: AppTheme.basicTheme(),
          
        ),
      ),
    );
  }
}
