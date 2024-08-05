import 'package:dio/dio.dart';
import 'package:insight_post/common/constsnts/apis.dart';
import 'package:insight_post/features/users/model/user_mdoel.dart';
import 'package:insight_post/services/db/database_helper.dart';
import 'package:insight_post/services/network/dio_service.dart';
import 'package:insight_post/services/network_helper.dart';
import 'package:insight_post/utils/log_helper.dart';

class UserRepo {
  static DatabaseHelper db = DatabaseHelper();
  static getUsers({
    required Function(List<User> users) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      if (!(await NetworkHelper.hasInternetConnection())) {
        var users = await db.getUsers();
        if(users.isEmpty){
          onError("No Internet Connection");
        }else{
          onSuccess(users);
        }
        return;
      }

      var response = await DioService.get(
        endPoint: Apis.getUsersUrl,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var users = User.listFromJson(response.data);
        onSuccess(users);
        db.saveUsers(users);
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

  static getUserDetails({
    required int userId,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      if (!(await NetworkHelper.hasInternetConnection())) {
        var user = await db.getUser(whereString: "id=?", args: ["$userId"]);
        if (user != null) {
          onSuccess(user);
        } else {
          onError("User not found");
        }
        return;
      }

      var response = await DioService.get(
        endPoint: "${Apis.getUsersUrl}/$userId",
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var user = User.fromJson(response.data);
        onSuccess(user);
        db.saveUser(user);
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
