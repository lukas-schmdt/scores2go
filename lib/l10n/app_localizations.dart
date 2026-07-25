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

  /// No description provided for @reportMissingScore.
  ///
  /// In de, this message translates to:
  /// **'Fehlenden Score melden'**
  String get reportMissingScore;

  /// No description provided for @reportMissingScoreSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Nicht gefunden was du suchst? Lass es uns wissen!'**
  String get reportMissingScoreSubtitle;

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

  /// No description provided for @disclaimerTitle.
  ///
  /// In de, this message translates to:
  /// **'Haftungsausschluss'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerIntendedUseTitle.
  ///
  /// In de, this message translates to:
  /// **'Zweckbestimmung'**
  String get disclaimerIntendedUseTitle;

  /// No description provided for @disclaimerIntendedUseBody.
  ///
  /// In de, this message translates to:
  /// **'Scores2Go ist als informatorisches und pädagogisches Referenzwerkzeug für ausgebildete medizinische Fachkräfte konzipiert. Die Anwendung führt mathematische Berechnungen auf Basis publizierter klinischer Scoringsysteme und benutzerseitig eingegebener Werte durch. Sie ist nicht dafür vorgesehen und darf nicht als alleinige Grundlage für klinische Entscheidungen verwendet werden.'**
  String get disclaimerIntendedUseBody;

  /// No description provided for @disclaimerRegulatoryTitle.
  ///
  /// In de, this message translates to:
  /// **'Regulatorischer Status'**
  String get disclaimerRegulatoryTitle;

  /// No description provided for @disclaimerRegulatoryBody.
  ///
  /// In de, this message translates to:
  /// **'Scores2Go ist nicht zur Diagnose, Prognose, Überwachung oder Behandlung von Erkrankungen bestimmt. Es handelt sich nicht um ein Medizinprodukt im Sinne der Verordnung (EU) 2017/745 (MDR). Die Anwendung führt ausschließlich mathematische Berechnungen durch und gibt Ergebnisse als Scorewerte ohne diagnostische Schlussfolgerungen, Behandlungsempfehlungen oder klinische Prognosen aus.'**
  String get disclaimerRegulatoryBody;

  /// No description provided for @disclaimerNoAdviceTitle.
  ///
  /// In de, this message translates to:
  /// **'Kein medizinischer Rat'**
  String get disclaimerNoAdviceTitle;

  /// No description provided for @disclaimerNoAdviceBody.
  ///
  /// In de, this message translates to:
  /// **'Scores2Go gibt keine medizinischen Ratschläge, Diagnosen oder Behandlungsempfehlungen. Klinische Entscheidungen dürfen nicht ausschließlich auf Grundlage der Ergebnisse dieser Anwendung getroffen werden. Nutzer tragen die alleinige Verantwortung für Patientenbeurteilung, Diagnose und alle klinischen Entscheidungen.'**
  String get disclaimerNoAdviceBody;

  /// No description provided for @disclaimerAccuracyTitle.
  ///
  /// In de, this message translates to:
  /// **'Genauigkeit & Haftung'**
  String get disclaimerAccuracyTitle;

  /// No description provided for @disclaimerAccuracyBody.
  ///
  /// In de, this message translates to:
  /// **'Es wurden angemessene Bemühungen unternommen, die Scoring-Formeln auf Grundlage publizierter wissenschaftlicher Literatur korrekt umzusetzen. Es wird jedoch keine Garantie hinsichtlich Vollständigkeit, Richtigkeit oder Eignung für einen bestimmten Zweck übernommen. Die Betreiber von Scores2Go haften nicht für Schäden, die aus der Nutzung der Anwendung entstehen, es sei denn, diese beruhen auf Vorsatz, grober Fahrlässigkeit oder gesetzlich zwingender Haftung.'**
  String get disclaimerAccuracyBody;

  /// No description provided for @disclaimerPrivacyTitle.
  ///
  /// In de, this message translates to:
  /// **'Daten & Datenschutz'**
  String get disclaimerPrivacyTitle;

  /// No description provided for @disclaimerPrivacyBody.
  ///
  /// In de, this message translates to:
  /// **'Scores2Go erhebt, speichert oder übermittelt keine Patientendaten. Alle Score-Berechnungen werden lokal auf Ihrem Gerät durchgeführt. Lediglich Ihre Zugangsdaten (E-Mail-Adresse) werden zu Authentifizierungszwecken gespeichert. Gesundheitsbezogene Daten werden nicht mit Ihrem Konto verknüpft.'**
  String get disclaimerPrivacyBody;

  /// No description provided for @resultLabel.
  ///
  /// In de, this message translates to:
  /// **'Ergebnis'**
  String get resultLabel;

  /// No description provided for @pointsLabel.
  ///
  /// In de, this message translates to:
  /// **'Punkte'**
  String get pointsLabel;

  /// No description provided for @incompleteResult.
  ///
  /// In de, this message translates to:
  /// **'Unvollständig'**
  String get incompleteResult;

  /// No description provided for @errorLabel.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get errorLabel;

  /// No description provided for @noDataAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Daten verfügbar'**
  String get noDataAvailable;

  /// No description provided for @calculating.
  ///
  /// In de, this message translates to:
  /// **'Berechnung läuft …'**
  String get calculating;

  /// No description provided for @noInterpretationAvailable.
  ///
  /// In de, this message translates to:
  /// **'Keine Interpretation verfügbar'**
  String get noInterpretationAvailable;

  /// No description provided for @yes.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get no;

  /// No description provided for @valueLabel.
  ///
  /// In de, this message translates to:
  /// **'Wert'**
  String get valueLabel;

  /// No description provided for @invalidNumber.
  ///
  /// In de, this message translates to:
  /// **'Ungültige Zahl'**
  String get invalidNumber;

  /// No description provided for @useDotOrCommaNotBoth.
  ///
  /// In de, this message translates to:
  /// **'Punkt oder Komma verwenden, nicht beides'**
  String get useDotOrCommaNotBoth;

  /// No description provided for @unsupportedVariableType.
  ///
  /// In de, this message translates to:
  /// **'Nicht unterstützter Variablentyp'**
  String get unsupportedVariableType;

  /// No description provided for @unsupportedVariableTypeDetail.
  ///
  /// In de, this message translates to:
  /// **'Nicht unterstützter Variablentyp: {type}'**
  String unsupportedVariableTypeDetail(Object type);

  /// No description provided for @initialState.
  ///
  /// In de, this message translates to:
  /// **'Initialer Zustand'**
  String get initialState;

  /// No description provided for @errorLoadingScore.
  ///
  /// In de, this message translates to:
  /// **'Fehler beim Laden des Scores'**
  String get errorLoadingScore;

  /// No description provided for @unknownState.
  ///
  /// In de, this message translates to:
  /// **'Unbekannter Zustand'**
  String get unknownState;

  /// No description provided for @collectionsTitle.
  ///
  /// In de, this message translates to:
  /// **'Sammlungen'**
  String get collectionsTitle;

  /// No description provided for @addToCollection.
  ///
  /// In de, this message translates to:
  /// **'Zu Sammlung hinzufügen'**
  String get addToCollection;

  /// No description provided for @noCollectionsYet.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Sammlungen. Erstelle unten eine neue.'**
  String get noCollectionsYet;

  /// No description provided for @newCollection.
  ///
  /// In de, this message translates to:
  /// **'Neue Sammlung'**
  String get newCollection;

  /// No description provided for @done.
  ///
  /// In de, this message translates to:
  /// **'Fertig'**
  String get done;

  /// No description provided for @collectionNameHint.
  ///
  /// In de, this message translates to:
  /// **'Name der Sammlung'**
  String get collectionNameHint;

  /// No description provided for @create.
  ///
  /// In de, this message translates to:
  /// **'Erstellen'**
  String get create;

  /// No description provided for @renameCollectionTooltip.
  ///
  /// In de, this message translates to:
  /// **'Umbenennen'**
  String get renameCollectionTooltip;

  /// No description provided for @deleteCollectionTooltip.
  ///
  /// In de, this message translates to:
  /// **'Sammlung löschen'**
  String get deleteCollectionTooltip;

  /// No description provided for @renameCollectionTitle.
  ///
  /// In de, this message translates to:
  /// **'Sammlung umbenennen'**
  String get renameCollectionTitle;

  /// No description provided for @noScoresYetTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Scores'**
  String get noScoresYetTitle;

  /// No description provided for @noScoresYetSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Füge Scores über den Tab „Durchsuchen“ hinzu.'**
  String get noScoresYetSubtitle;

  /// No description provided for @deleteCollectionQuestion.
  ///
  /// In de, this message translates to:
  /// **'Sammlung löschen?'**
  String get deleteCollectionQuestion;

  /// No description provided for @deleteCollectionConfirmBody.
  ///
  /// In de, this message translates to:
  /// **'„{name}“ wird gelöscht. Scores sind davon nicht betroffen.'**
  String deleteCollectionConfirmBody(Object name);

  /// No description provided for @shareYourFeedback.
  ///
  /// In de, this message translates to:
  /// **'Teile dein Feedback'**
  String get shareYourFeedback;

  /// No description provided for @close.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get close;

  /// No description provided for @send.
  ///
  /// In de, this message translates to:
  /// **'Senden'**
  String get send;

  /// No description provided for @feedbackPrompt.
  ///
  /// In de, this message translates to:
  /// **'Wie gefällt dir die App? Lass uns wissen, was du denkst oder was fehlt.'**
  String get feedbackPrompt;

  /// No description provided for @feedbackHint.
  ///
  /// In de, this message translates to:
  /// **'Welcher Score fehlt, oder sonstiges Feedback…'**
  String get feedbackHint;

  /// No description provided for @feedbackSendFailed.
  ///
  /// In de, this message translates to:
  /// **'Feedback konnte nicht gesendet werden. Bitte erneut versuchen.'**
  String get feedbackSendFailed;

  /// No description provided for @feedbackThankYou.
  ///
  /// In de, this message translates to:
  /// **'Dein Feedback wurde übermittelt.'**
  String get feedbackThankYou;

  /// No description provided for @missingScorePrefill.
  ///
  /// In de, this message translates to:
  /// **'Fehlender Score: {query}'**
  String missingScorePrefill(Object query);

  /// No description provided for @buyMeACoffee.
  ///
  /// In de, this message translates to:
  /// **'Spendier mir einen Kaffee'**
  String get buyMeACoffee;
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
