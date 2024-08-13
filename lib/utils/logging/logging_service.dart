// ignore: file_names
import 'package:newrelic_mobile/newrelic_mobile.dart';

class LoggingService {
  LoggingService._privateConstructor();

  static final LoggingService _instance = LoggingService._privateConstructor();

  static LoggingService get instance => _instance;

  void logError(String message) {
    NewrelicMobile.instance.logError(message);
  }

  void logInfo(String message) {
    NewrelicMobile.instance.logInfo(message);
  }

  void logWarning(String message) {
    NewrelicMobile.instance.logWarning(message);
  }

  void logVerbose(String message) {
    NewrelicMobile.instance.logVerbose(message);
  }

  void logDebug(String message) {
    NewrelicMobile.instance.logDebug(message);
  }

  void logINitialText(String message) {
    NewrelicMobile.instance.logInfo("testing logs");
    NewrelicMobile.instance.logDebug("testing logs debug");
    NewrelicMobile.instance.logWarning("testing logs warning");
    NewrelicMobile.instance.logVerbose("testing logs verbose");
  }
}
