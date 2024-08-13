// ignore: file_names
import 'dart:io';
import 'package:newrelic_mobile/config.dart';

class Newrelic {
  static final Newrelic _instance = Newrelic._internal();
  static Newrelic get instance => _instance;

  factory Newrelic() {
    return _instance;
  }

  Newrelic._internal();

  var appToken = "";

  Future<Config> start() async {
    if (Platform.isIOS) {
      appToken = 'eu01xxcf835f59c648a12ed79f1289fe58f1b499af-NRMA';
    } else if (Platform.isAndroid) {
      appToken = 'eu01xx688f84454c5ba2f4aaf05b0035222c73f3ca-NRMA';
    }

    Config config = Config(
      accessToken: appToken,
      analyticsEventEnabled: true,
      webViewInstrumentation: true,
      networkErrorRequestEnabled: true,
      networkRequestEnabled: true,
      crashReportingEnabled: true,
      interactionTracingEnabled: true,
      httpResponseBodyCaptureEnabled: true,
      loggingEnabled: true,
      printStatementAsEventsEnabled: true,
      httpInstrumentationEnabled: true,
    );

    return config;
  }
}
