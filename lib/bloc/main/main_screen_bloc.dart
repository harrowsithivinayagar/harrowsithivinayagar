import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_event.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_state.dart';
import 'package:harrowsithivinayagar/repository/login/login_repository.dart';
import 'package:harrowsithivinayagar/utils/firebase/remote_config_service.dart';
import 'package:harrowsithivinayagar/utils/logging/logging_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final LoginRepository loginRepo;
  MainScreenBloc(this.loginRepo) : super(MainScreenInitial()) {
    on<InitializeMainScreen>(_onInitializeMainScreen);
    on<LogoutEvent>(onlogoutAction);
  }

  Future<void> onlogoutAction(
    LogoutEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    await loginRepo.signoutUser();
    emit(MainScreenLogout());
  }

  Future<void> _onInitializeMainScreen(
    InitializeMainScreen event,
    Emitter<MainScreenState> emit,
  ) async {
    emit(MainScreenLoading());

    try {
      final remoteConfigService = await RemoteConfigService.create();
      final requiredMinimumVersion =
          remoteConfigService.getRequiredMinimumVersion();
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (_isUpdateRequired(currentVersion, requiredMinimumVersion)) {
        emit(MainScreenUpdateRequired());
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final role = prefs.getString('role') ?? 'user';
        emit(MainScreenLoaded(role));
      }
    } catch (e) {
      LoggingService.instance.logError('Error initializing main screen: $e');
      emit(MainScreenError('Error initializing main screen: $e'));
    }
  }

  bool _isUpdateRequired(String currentVersion, String requiredMinimumVersion) {
    final currentVersionNumber = _getExtendedVersionNumber(currentVersion);
    final requiredVersionNumber =
        _getExtendedVersionNumber(requiredMinimumVersion);
    return currentVersionNumber < requiredVersionNumber;
  }

  int _getExtendedVersionNumber(String version) {
    final versionCells = version.split('.').map(int.parse).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
