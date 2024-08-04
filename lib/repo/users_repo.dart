import 'package:dio/dio.dart';
import 'package:insight_post/common/constsnts/apis.dart';
import 'package:insight_post/features/home/model/post_model.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/services/network/dio_service.dart';
import 'package:insight_post/utils/log_helper.dart';

class UserRepo {
  static getUsers({
    required Function(List<User> posts) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var response = await DioService.get(
        endPoint: Apis.getUsersUrl,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var users = User.listFromJson(response.data);
        onSuccess(users);
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
