import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/post_details/view/post_details_screen.dart';

class PostDetailRoute extends GoRouteData {
  final PostModel post;

  PostDetailRoute(
    this.post,
  );

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PostDetailsScreen(post);
  }

  static PostDetailRoute _fromState(GoRouterState state) => PostDetailRoute(
        PostModel.fromJson(json.decode(state.uri.queryParameters['postId']!)),
      );

  String get location => GoRouteData.$location(
        "/${PostDetailsScreen.routes}",
        queryParams: {"postId": json.encode(post.toJson())},
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $postDetailRoute => GoRouteData.$route(
      path: PostDetailsScreen.routes,
      factory: PostDetailRoute._fromState,
    );
