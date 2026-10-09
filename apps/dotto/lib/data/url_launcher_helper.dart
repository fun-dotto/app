import 'package:dotto/foundation/log/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<bool> launchUrlSafely(
  String url, {
  required Logger logger,
  LaunchMode mode = .platformDefault,
}) async {
  try {
    return await launchUrlString(url, mode: mode);
  } on Exception catch (error, stack) {
    await logger.logError(error, stack);
    return false;
  }
}
