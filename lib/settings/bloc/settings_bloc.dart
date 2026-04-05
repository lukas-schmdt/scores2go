import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsEvent>((event, emit) async {
      if (event is getAppVersion) {
        WidgetsFlutterBinding.ensureInitialized();
        final packageInfo = await PackageInfo.fromPlatform();
        emit(state.copyWith(
          appVersion: packageInfo.version,
          appName: packageInfo.appName,
          packageName: packageInfo.packageName,
          buildNumber: packageInfo.buildNumber,
        ));
      }
      if (event is ToggleDarkModeEvent) {
        emit(state.copyWith(isDarkMode: !state.isDarkMode));
      }
    });
  }
}
