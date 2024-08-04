import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/features/home/view/widget/post_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.only(
          top: 30.h,
          bottom: 60.h,
          left: 20.w,
          right: 20.w,
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 24.h,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const PostWidget();
        },
      ),
    );
  }
}
