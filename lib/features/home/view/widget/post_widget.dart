import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insight_post/common/constsnts/svg_constants.dart';
import 'package:insight_post/common/controllers/user_provider.dart';
import 'package:insight_post/common/route/post_details_route.dart';
import 'package:insight_post/common/widgets/circular_text_widget.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/post_details/view/post_details_screen.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/utils/url_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostWidget extends ConsumerWidget {
  final bool allowNabigation;
  final PostModel post;
  const PostWidget({
    super.key,
    this.allowNabigation = true,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider(post.userId ?? -1));
    return user.when(
      data: (data) => _buildPostWidget(context, isLoading: false, user: data),
      error: (error, stackTrace) => _buildPostWidget(
        context,
      ),
      loading: () => _buildPostWidget(
        context,
        isLoading: true,
      ),
    );
  }

  Widget _buildPostWidget(BuildContext context,
      {bool isLoading = false, User? user}) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Skeletonizer(
      enabled: isLoading,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (allowNabigation) {
            PostDetailRoute(post).go(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircularText(
                  name: user?.name ?? "N/A",
                  radius: 25.r,
                  fontSize: 20.sp,
                  colorAsIndex: user?.id,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "N/A",
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      "@${user?.username ?? "N/A"}",
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              post.title ?? "",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              post.body ?? "",
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: theme.colorScheme.outline,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: SvgPicture.asset(
                //     SvgConstants.heart,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    if (allowNabigation) {
                      PostDetailRoute(post).go(context);
                    }
                  },
                  icon: SvgPicture.asset(
                    SvgConstants.message,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    UrlLaunchHelper.sharePost(post, user?.username ?? "");
                  },
                  icon: SvgPicture.asset(
                    SvgConstants.share,
                  ),
                )
              ],
            ),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: theme.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
