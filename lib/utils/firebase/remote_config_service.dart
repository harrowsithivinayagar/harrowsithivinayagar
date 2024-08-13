import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService._internal(this._remoteConfig);

  static Future<RemoteConfigService> create() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.setDefaults(<String, dynamic>{
      'requiredMinimumVersion': "0.0.0", // Default minimum version
    });

    await remoteConfig.fetchAndActivate();
    return RemoteConfigService._internal(remoteConfig);
  }

  String getRequiredMinimumVersion() {
    var version = _remoteConfig.getString('requiredMinimumVersion');
    return version;
  }
}
