import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/common/widgets/status/generic_status.dart';
import 'package:insight_post/features/home/controller.dart/home_controller.dart';
import 'package:insight_post/features/home/view/widget/post_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(homeProvider.notifier).fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      body: state.when<Widget>(
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (data) => ListView.separated(
          padding: EdgeInsets.only(
            top: 30.h,
            bottom: 60.h,
            left: 20.w,
            right: 20.w,
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 24.h,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            var post = data[index];
            return PostWidget(
              post: post,
            );
          },
        ),
        error: (message) => Center(
          child: GenericStatusWidget(
            message: message,
            onRetry: () {
              ref.read(homeProvider.notifier).fetchPosts();
            },
          ),
        ),
      ),
    );
  }
}
