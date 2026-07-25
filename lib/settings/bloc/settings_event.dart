part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleDarkModeEvent extends SettingsEvent {
  const ToggleDarkModeEvent({required this.currentIsDark});
  final bool currentIsDark;

  @override
  List<Object> get props => [currentIsDark];
}

class SetLocaleEvent extends SettingsEvent {
  const SetLocaleEvent(this.locale);
  final Locale? locale; // null = use device locale

  @override
  List<Object> get props => [?locale];
}

class GetAppVersion extends SettingsEvent {}
