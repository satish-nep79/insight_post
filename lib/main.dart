import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/constsnts/app_theme.dart';
import 'package:insight_post/common/constsnts/app_values.dart';
import 'package:insight_post/common/constsnts/size_constants.dart';
import 'package:insight_post/common/route/app_routes.dart';
import 'package:insight_post/services/db/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.getDb();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final routes = RouteManager().goRouter(AppValues.navKey, ref);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: SizeConstants.screenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child ?? const SizedBox(),
      child: Consumer(
        builder: (context, ref, _) => MaterialApp.router(
          scaffoldMessengerKey: AppValues.snackBarMessengerKey,
          debugShowCheckedModeBanner: false,
          builder: (context, child) => child ?? const SizedBox(),
          title: "Insight Post",
          theme: AppTheme.basicTheme(),
          routerConfig: routes,
        ),
      ),
    );
  }
}
