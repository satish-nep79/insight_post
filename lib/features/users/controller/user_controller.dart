import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insight_post/common/models/generic_states.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/repo/users_repo.dart';

final usersProvider =
    StateNotifierProvider.autoDispose<UsersNotifier, GenericState<List<User>>>(
  (ref) => UsersNotifier(const LoadingState()),
);

class UsersNotifier extends StateNotifier<GenericState<List<User>>> {
  UsersNotifier(super.state);

  Future<void> fetchUsers() async {
    Future.delayed(Duration.zero);
    state = const LoadingState();
    UserRepo.getUsers(
      onSuccess: (users) {
        state = SuccessState(users);
      },
      onError: (message) {
        state = ErrorState(message);
      },
    );
  }
}
