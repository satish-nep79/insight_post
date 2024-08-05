import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/common/widgets/generic_appbar.dart';
import 'package:insight_post/common/widgets/generic_textfield.dart';
import 'package:insight_post/common/widgets/status/generic_status.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/home/view/widget/post_widget.dart';
import 'package:insight_post/features/post_details/controller/post_detail_controller.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';
import 'package:insight_post/features/post_details/view/widget/comment_widget.dart';

class PostDetailsScreen extends ConsumerStatefulWidget {
  static const routes = "post";
  final PostModel post;
  const PostDetailsScreen(this.post, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsScreenState();
}

class _PostDetailsScreenState extends ConsumerState<PostDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  final commentTextController = TextEditingController();

  @override
  void initState() {
    ref.read(postDetailsProvider.notifier).fetchComments(widget.post.id!);
    super.initState();
  }

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    final state = ref.watch(postDetailsProvider);

    return Scaffold(
      appBar: const GenericAppbar(
        title: "Post",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer(
        builder: (context, localRef, _) {
          final localState = localRef.watch(postCommentProvider);
          return Container(
            color: theme.scaffoldBackgroundColor,
            child: GenericTextField(
              hint: "Add Comment",
              controller: commentTextController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              suffixIcon: localState is LoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildPostButton(
                      localRef,
                    ),
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostWidget(
                    post: widget.post,
                    allowNabigation: false,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Comments",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.h,
                    color: theme.colorScheme.outline,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            state.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              success: (data) => SliverList.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var comment = data[index];
                  return CommentWidget(
                    comment: comment,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
              ),
              empty: () => const SliverFillRemaining(
                child: GenericStatusWidget(
                  title: "No comments",
                  message:
                      "Oops! looks like there are no comments at the moment",
                ),
              ),
              error: (message) =>
                  const SliverFillRemaining(child: GenericStatusWidget()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120.h,
              ),
            )
          ],
        ),
      ),
    );
  }

  _submitComment(WidgetRef localRef) async {
    var commentText = commentTextController.text;
    if (commentText.isNotEmpty) {
      FocusScope.of(context).unfocus();
      var comment = CommentModel(
        body: commentText,
        postId: widget.post.id,
        email: "satish79@gmail;.com",
        name: "Test Comment",
      );
      ref.read(postCommentProvider.notifier).postComment(comment);
    }
  }

  IconButton _buildPostButton(WidgetRef localRef) {
    return IconButton(
      onPressed: () => _submitComment(localRef),
      icon: Icon(
        Icons.send,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
