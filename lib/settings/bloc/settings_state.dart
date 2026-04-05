part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.appVersion = '',
    this.appName = '',
    this.packageName = '',
    this.buildNumber = '',
    this.locale, // null = use device locale
  });

  final bool isDarkMode;
  final String appVersion;
  final String appName;
  final String packageName;
  final String buildNumber;
  final Locale? locale;

  SettingsState copyWith({
    bool? isDarkMode,
    String? appVersion,
    String? appName,
    String? packageName,
    String? buildNumber,
    Locale? locale,
    bool clearLocale = false,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      appVersion: appVersion ?? this.appVersion,
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      buildNumber: buildNumber ?? this.buildNumber,
      locale: clearLocale ? null : (locale ?? this.locale),
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        appName,
        packageName,
        appVersion,
        buildNumber,
        locale,
      ];
}
