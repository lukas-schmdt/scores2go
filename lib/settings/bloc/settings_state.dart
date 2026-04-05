part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.appVersion = '',
    this.appName = '',
    this.packageName = '',
    this.buildNumber = '',
  });

  final bool isDarkMode;
  final String appVersion;
  final String appName;
  final String packageName;
  final String buildNumber;

  SettingsState copyWith({
    bool? isDarkMode,
    String? appVersion,
    String? appName,
    String? packageName,
    String? buildNumber,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      appVersion: appVersion ?? this.appVersion,
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }

  @override
  List<Object> get props => [
        isDarkMode,
        appName,
        packageName,
        appVersion,
        buildNumber,
      ];
}
