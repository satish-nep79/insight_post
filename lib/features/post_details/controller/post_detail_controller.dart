import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';
import 'package:insight_post/repo/post_repo.dart';
import 'package:insight_post/services/snack_bar_service.dart';

final postDetailsProvider = StateNotifierProvider.autoDispose<
    PostDetailNotifier, GenericState<List<CommentModel>>>(
  (ref) => PostDetailNotifier(const LoadingState()),
);

final postCommentProvider = StateNotifierProvider.autoDispose<
    PostCommentNotifier, GenericState<CommentModel>>(
  (ref) => PostCommentNotifier(const InitialState()),
);

class PostCommentNotifier extends StateNotifier<GenericState<CommentModel>> {
  PostCommentNotifier(super.state);

  Future<void> postComment(CommentModel comment) async {
    state = const LoadingState();

    PostRepo.postComment(
      postId: comment.postId!,
      comment: comment,
      onSuccess: (comment) {
        state = SuccessState(comment);
        SnackBarService.showSuccess(
            title: "Comment",
            message: "Your comment has been posted succesfully");
      },
      onError: (message) {
        state = ErrorState(message);
        SnackBarService.showError(title: "Comment", message: message);
      },
    );
  }
}

class PostDetailNotifier
    extends StateNotifier<GenericState<List<CommentModel>>> {
  PostDetailNotifier(super.state);

  Future<void> fetchComments(int postId) async {
    Future.delayed(Duration.zero);
    state = const LoadingState();
    PostRepo.getComments(
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
