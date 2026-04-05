part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleDarkModeEvent extends SettingsEvent {
  const ToggleDarkModeEvent();
}

class SetLocaleEvent extends SettingsEvent {
  const SetLocaleEvent(this.locale);
  final Locale? locale; // null = use device locale

  @override
  List<Object> get props => [if (locale != null) locale!];
}

class getAppVersion extends SettingsEvent {}
