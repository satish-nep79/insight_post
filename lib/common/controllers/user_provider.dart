import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/repo/users_repo.dart';

final userDataProvider = FutureProvider.family<User?, int>(
  (ref, userId) async {
    final completer = Completer<User?>();
    log("Fetching user ===> ${userId}");
    UserRepo.getUserDetails(
      userId: userId,
      onSuccess: (user) {
        completer.complete(user);
      },
      onError: (message) {
        completer.complete(null);
      },
    );
    return completer.future;
  },
);
