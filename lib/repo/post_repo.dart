import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insight_post/common/constsnts/apis.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/services/network/dio_service.dart';
import 'package:insight_post/utils/log_helper.dart';

class PostRepo {
  static getPosts({
    required Function(List<PostModel> posts) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var response = await DioService.get(
        endPoint: Apis.getPostsUrl,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var posts = PostModel.listFromJson(response.data);
        onSuccess(posts);
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
