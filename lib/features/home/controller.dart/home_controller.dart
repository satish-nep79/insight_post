import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/repo/post_repo.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier,
    GenericState<List<PostModel>>>(
  (ref) => HomeNotifier(const LoadingState()),
);

class HomeNotifier extends StateNotifier<GenericState<List<PostModel>>> {
  HomeNotifier(super.state);

  Future<void> fetchPosts() async {
    Future.delayed(Duration.zero);
    state = const LoadingState();
    PostRepo.getPosts(
      onSuccess: (posts) {
        state = SuccessState(posts);
      },
      onError: (message) {
        state = ErrorState(message);
      },
    );
  }
}
