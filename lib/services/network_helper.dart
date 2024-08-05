import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:insight_post/utils/log_helper.dart';

class NetworkHelper {
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      LogHelper.info(
          title: "Inter net connection", message: "Has Inter net connection");
      return true;
    } else {
       LogHelper.info(
          title: "Inter net connection", message: "Doesnot has Inter net connection");
      return false;
    }
  }
}
