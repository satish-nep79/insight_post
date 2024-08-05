import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insight_post/common/constsnts/apis.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/post_details/models/comment_model.dart';
import 'package:insight_post/services/db/database_helper.dart';
import 'package:insight_post/services/network/dio_service.dart';
import 'package:insight_post/services/network_helper.dart';
import 'package:insight_post/utils/log_helper.dart';

class PostRepo {
  static DatabaseHelper db = DatabaseHelper();
  static getPosts({
    required Function(List<PostModel> posts) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var hasInternet = await NetworkHelper.hasInternetConnection();
      if (!hasInternet) {
        log("Fetching posts");
        var posts = await db.getPosts();
        if (posts.isEmpty) {
          onError("No Internet Connection");
        } else {
          onSuccess(posts);
        }
        return;
      }

      var response = await DioService.get(
        endPoint: Apis.getPostsUrl,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var posts = PostModel.listFromJson(response.data);
        onSuccess(posts);
        db.savePosts(posts);
      } else {
        throw "Faced ${response.statusCode} Error";
      }
    } on DioException catch (e, s) {
      onError(e.message ?? "Sorry!! something went wrong");
      LogHelper.error(title: Apis.getPostsUrl, error: e, stackTrace: s);
    } catch (e, s) {
      onError("Sorry!! something went wrong");
      LogHelper.error(title: Apis.getPostsUrl, error: e, stackTrace: s);
    }
  }

  static getComments({
    required int postId,
    required Function(List<CommentModel> comments) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var response = await DioService.get(
        endPoint: Apis.getPostCommentsUrl(postId),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var comments = CommentModel.listFromJson(response.data);
        onSuccess(comments);
      } else {
        throw "Faced ${response.statusCode} Error";
      }
    } on DioException catch (e, s) {
      onError(e.message ?? "Sorry!! something went wrong");
      LogHelper.error(title: Apis.getPostsUrl, error: e, stackTrace: s);
    } catch (e, s) {
      onError("Sorry!! something went wrong");
      LogHelper.error(title: Apis.getPostsUrl, error: e, stackTrace: s);
    }
  }
}
