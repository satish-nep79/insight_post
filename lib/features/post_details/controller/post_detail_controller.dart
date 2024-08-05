import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';
import 'package:insight_post/repo/post_repo.dart';

final postDetailsProvider = StateNotifierProvider.autoDispose<
    PostDetailNotifier, GenericState<List<CommentModel>>>(
  (ref) => PostDetailNotifier(const LoadingState()),
);

class PostDetailNotifier
    extends StateNotifier<GenericState<List<CommentModel>>> {
  PostDetailNotifier(super.state);

  Future<void> fetchComments(int postId) async {
    Future.delayed(Duration.zero);
    state = const LoadingState();
    PostRepo. getComments(
      postId: postId,
      onSuccess: (posts) {
        state = SuccessState(posts);
      },
      onError: (message) {
        state = ErrorState(message);
      },
    );
  }
}
