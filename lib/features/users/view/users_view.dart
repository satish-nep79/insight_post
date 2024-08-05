import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/common/widgets/status/generic_status.dart';
import 'package:insight_post/features/users/controller/user_controller.dart';
import 'package:insight_post/features/users/view/widget/user_row.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  @override
  void initState() {
    ref.read(usersProvider.notifier).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usersProvider);

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
            var user = data[index];
            return UserRow(
              user: user,
              index: index,
            );
          },
        ),
        empty: () => const GenericStatusWidget(
          title: "No users",
          message: "Oops! looks like there are no users at the moment",
        ),
        error: (message) => Center(
          child: GenericStatusWidget(
            message: message,
            onRetry: () {
              ref.read(usersProvider.notifier).fetchUsers();
            },
          ),
        ),
      ),
    );
  }
}
