import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Scores2Go'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Klinische Bewertungstools'**
  String get appSubtitle;

  /// No description provided for @navBrowse.
  ///
  /// In de, this message translates to:
  /// **'Browse'**
  String get navBrowse;

  /// No description provided for @navFavorites.
  ///
  /// In de, this message translates to:
  /// **'Favoriten'**
  String get navFavorites;

  /// No description provided for @navRecentlyUsed.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt verwendet'**
  String get navRecentlyUsed;

  /// No description provided for @navProfile.
  ///
  /// In de, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @emailLabel.
  ///
  /// In de, this message translates to:
  /// **'E-Mail-Adresse'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get passwordLabel;

  /// No description provided for @login.
  ///
  /// In de, this message translates to:
  /// **'Anmelden'**
  String get login;

  /// No description provided for @loginFailed.
  ///
  /// In de, this message translates to:
  /// **'Anmeldung fehlgeschlagen. Bitte erneut versuchen.'**
  String get loginFailed;

  /// No description provided for @forgotPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort vergessen?'**
  String get forgotPassword;

  /// No description provided for @noAccountRegister.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Konto? Registrieren'**
  String get noAccountRegister;

  /// No description provided for @createAccount.
  ///
  /// In de, this message translates to:
  /// **'Konto erstellen'**
  String get createAccount;

  /// No description provided for @confirmPassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort bestätigen'**
  String get confirmPassword;

  /// No description provided for @register.
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get register;

  /// No description provided for @registrationFailed.
  ///
  /// In de, this message translates to:
  /// **'Registrierung fehlgeschlagen. Bitte erneut versuchen.'**
  String get registrationFailed;

  /// No description provided for @alreadyAccountLogin.
  ///
  /// In de, this message translates to:
  /// **'Bereits ein Konto? Anmelden'**
  String get alreadyAccountLogin;

  /// No description provided for @backToLogin.
  ///
  /// In de, this message translates to:
  /// **'Zurück zur Anmeldung'**
  String get backToLogin;

  /// No description provided for @emailCheckTitle.
  ///
  /// In de, this message translates to:
  /// **'E-Mail prüfen'**
  String get emailCheckTitle;

  /// No description provided for @emailCheckSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Wir haben einen Bestätigungslink an deine E-Mail gesendet. Klicke darauf, um dein Konto zu aktivieren.'**
  String get emailCheckSubtitle;

  /// No description provided for @checkInboxForResetLink.
  ///
  /// In de, this message translates to:
  /// **'Prüfe deinen Posteingang für den Passwort-Reset-Link.'**
  String get checkInboxForResetLink;

  /// No description provided for @resetEmailFailed.
  ///
  /// In de, this message translates to:
  /// **'Reset-E-Mail konnte nicht gesendet werden. Bitte erneut versuchen.'**
  String get resetEmailFailed;

  /// No description provided for @sendResetEmail.
  ///
  /// In de, this message translates to:
  /// **'Reset-E-Mail senden'**
  String get sendResetEmail;

  /// No description provided for @emailSent.
  ///
  /// In de, this message translates to:
  /// **'E-Mail gesendet'**
  String get emailSent;

  /// No description provided for @newPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In de, this message translates to:
  /// **'Neues Passwort bestätigen'**
  String get confirmNewPassword;

  /// No description provided for @passwordResetFailed.
  ///
  /// In de, this message translates to:
  /// **'Passwort konnte nicht zurückgesetzt werden. Bitte erneut versuchen.'**
  String get passwordResetFailed;

  /// No description provided for @savePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort speichern'**
  String get savePassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort wurde zurückgesetzt. Bitte anmelden.'**
  String get passwordResetSuccess;

  /// No description provided for @fillAllFields.
  ///
  /// In de, this message translates to:
  /// **'Bitte alle Felder ausfüllen.'**
  String get fillAllFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein.'**
  String get passwordsDoNotMatch;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In de, this message translates to:
  /// **'Konto'**
  String get account;

  /// No description provided for @email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// No description provided for @noEmailAddress.
  ///
  /// In de, this message translates to:
  /// **'Keine E-Mail-Adresse'**
  String get noEmailAddress;

  /// No description provided for @password.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get password;

  /// No description provided for @changePassword.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePassword;

  /// No description provided for @logout.
  ///
  /// In de, this message translates to:
  /// **'Abmelden'**
  String get logout;

  /// No description provided for @appSection.
  ///
  /// In de, this message translates to:
  /// **'App'**
  String get appSection;

  /// No description provided for @appearance.
  ///
  /// In de, this message translates to:
  /// **'Erscheinungsbild'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In de, this message translates to:
  /// **'Dunkelmodus'**
  String get darkMode;

  /// No description provided for @appNameLabel.
  ///
  /// In de, this message translates to:
  /// **'App-Name'**
  String get appNameLabel;

  /// No description provided for @packageNameLabel.
  ///
  /// In de, this message translates to:
  /// **'Paketname'**
  String get packageNameLabel;

  /// No description provided for @versionLabel.
  ///
  /// In de, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @buildNumberLabel.
  ///
  /// In de, this message translates to:
  /// **'Build-Nummer'**
  String get buildNumberLabel;

  /// No description provided for @changePasswordTitle.
  ///
  /// In de, this message translates to:
  /// **'Passwort ändern'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordError.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Ändern des Passworts.'**
  String get changePasswordError;

  /// No description provided for @minSixCharsRequired.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 6 Zeichen erforderlich.'**
  String get minSixCharsRequired;

  /// No description provided for @currentPassword.
  ///
  /// In de, this message translates to:
  /// **'Aktuelles Passwort'**
  String get currentPassword;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In de, this message translates to:
  /// **'Passwort erfolgreich geändert.'**
  String get passwordChangedSuccess;

  /// No description provided for @scores.
  ///
  /// In de, this message translates to:
  /// **'Scores'**
  String get scores;

  /// No description provided for @noResultsFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Ergebnisse gefunden'**
  String get noResultsFound;

  /// No description provided for @tryDifferentSearch.
  ///
  /// In de, this message translates to:
  /// **'Anderen Suchbegriff versuchen.'**
  String get tryDifferentSearch;

  /// No description provided for @noScoresAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Scores vorhanden'**
  String get noScoresAvailable;

  /// No description provided for @addScoresOrCheckConnection.
  ///
  /// In de, this message translates to:
  /// **'Scores hinzufügen oder Verbindung prüfen.'**
  String get addScoresOrCheckConnection;

  /// No description provided for @recentlyUsedTitle.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt verwendet'**
  String get recentlyUsedTitle;

  /// No description provided for @errorLoadingRecentScores.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden der letzten Scores'**
  String get errorLoadingRecentScores;

  /// No description provided for @favoritesTitle.
  ///
  /// In de, this message translates to:
  /// **'Favoriten'**
  String get favoritesTitle;

  /// No description provided for @errorLoadingFavorites.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden der Favoriten'**
  String get errorLoadingFavorites;

  /// No description provided for @noItemsFound.
  ///
  /// In de, this message translates to:
  /// **'Keine Elemente gefunden'**
  String get noItemsFound;

  /// No description provided for @pleaseSelectItem.
  ///
  /// In de, this message translates to:
  /// **'Bitte ein Element auswählen.'**
  String get pleaseSelectItem;

  /// No description provided for @drawerHome.
  ///
  /// In de, this message translates to:
  /// **'Start'**
  String get drawerHome;

  /// No description provided for @drawerAbout.
  ///
  /// In de, this message translates to:
  /// **'Über uns'**
  String get drawerAbout;

  /// No description provided for @languageLabel.
  ///
  /// In de, this message translates to:
  /// **'Sprache'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In de, this message translates to:
  /// **'Systemsprache'**
  String get languageSystem;

  /// No description provided for @languageDe.
  ///
  /// In de, this message translates to:
  /// **'Deutsch'**
  String get languageDe;

  /// No description provided for @languageEn.
  ///
  /// In de, this message translates to:
  /// **'English'**
  String get languageEn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
