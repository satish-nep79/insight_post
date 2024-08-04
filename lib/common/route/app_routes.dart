import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_post/features/dashboard/views/dashboard_screen.dart';
import 'package:insight_post/features/splash/view/splash_screen.dart';

class RouteManager {
  GoRouter goRouter(GlobalKey<NavigatorState> navKey, WidgetRef ref) {
    return GoRouter(
        navigatorKey: navKey,
        initialLocation: SplashScreen.route,
        // errorBuilder: (context, state) => ErrorScreen(),//TODO
        routes: [
          GoRoute(
            path: SplashScreen.route,
            builder: (_, __) => const SplashScreen(),
          ),
          GoRoute(
            path: DashboardScreen.route,
            builder: (_, __) => const DashboardScreen(),
          )
        ]);
  }
}
