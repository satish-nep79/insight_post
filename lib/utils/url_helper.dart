import 'package:insight_post/services/snack_bar_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunchHelper {
  static Future<void> website(String url) async {
    if (url.contains("https://") || url.contains("https://")) {
      url = "https://$url";
    }
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      SnackBarService.showError(
        title: "Url Launch",
        message: "Sorry we were unable to launch the website $url",
      );
    }
  }

  static Future<void> phone(String phone) async {
    var uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      SnackBarService.showError(
        title: "Dailer",
        message: "Sorry we were unable to launch the dailer for  $phone",
      );
    }
  }

  static Future<void> email(String email) async {
    var uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(uri)) {
      SnackBarService.showError(
        title: "Dailer",
        message: "Sorry we were unable to launch the dailer for  $phone",
      );
    }
  }
}
