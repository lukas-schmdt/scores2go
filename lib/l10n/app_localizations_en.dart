// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Scores2Go';

  @override
  String get appSubtitle => 'Clinical Assessment Tools';

  @override
  String get navBrowse => 'Browse';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navRecentlyUsed => 'Recently used';

  @override
  String get navProfile => 'Profile';

  @override
  String get emailLabel => 'Email address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get login => 'Sign in';

  @override
  String get loginFailed => 'Sign in failed. Please try again.';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccountRegister => 'No account yet? Register';

  @override
  String get createAccount => 'Create account';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get register => 'Register';

  @override
  String get registrationFailed => 'Registration failed. Please try again.';

  @override
  String get alreadyAccountLogin => 'Already have an account? Sign in';

  @override
  String get backToLogin => 'Back to sign in';

  @override
  String get emailCheckTitle => 'Check your email';

  @override
  String get emailCheckSubtitle =>
      'We sent a confirmation link to your email. Click it to activate your account.';

  @override
  String get checkInboxForResetLink =>
      'Check your inbox for the password reset link.';

  @override
  String get resetEmailFailed =>
      'Could not send reset email. Please try again.';

  @override
  String get sendResetEmail => 'Send reset email';

  @override
  String get emailSent => 'Email sent';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get passwordResetFailed =>
      'Password could not be reset. Please try again.';

  @override
  String get savePassword => 'Save password';

  @override
  String get passwordResetSuccess => 'Password reset. Please sign in.';

  @override
  String get fillAllFields => 'Please fill in all fields.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get settings => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get email => 'Email';

  @override
  String get noEmailAddress => 'No email address';

  @override
  String get password => 'Password';

  @override
  String get changePassword => 'Change password';

  @override
  String get logout => 'Sign out';

  @override
  String get appSection => 'App';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get appNameLabel => 'App name';

  @override
  String get packageNameLabel => 'Package name';

  @override
  String get versionLabel => 'Version';

  @override
  String get buildNumberLabel => 'Build number';

  @override
  String get changePasswordTitle => 'Change password';

  @override
  String get changePasswordError => 'Error changing password.';

  @override
  String get minSixCharsRequired => 'At least 6 characters required.';

  @override
  String get currentPassword => 'Current password';

  @override
  String get passwordChangedSuccess => 'Password changed successfully.';

  @override
  String get scores => 'Scores';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get tryDifferentSearch => 'Try a different search term.';

  @override
  String get reportMissingScore => 'Report missing score';

  @override
  String get reportMissingScoreSubtitle =>
      'Can\'t find what you\'re looking for? Let us know!';

  @override
  String get noScoresAvailable => 'No scores available';

  @override
  String get addScoresOrCheckConnection =>
      'Add scores or check your connection.';

  @override
  String get recentlyUsedTitle => 'Recently used';

  @override
  String get errorLoadingRecentScores => 'Error loading recent scores';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get errorLoadingFavorites => 'Error loading favorites';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get pleaseSelectItem => 'Please select an item.';

  @override
  String get drawerHome => 'Home';

  @override
  String get drawerAbout => 'About';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System language';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageEn => 'English';

  @override
  String get disclaimerTitle => 'Disclaimer';

  @override
  String get disclaimerIntendedUseTitle => 'Intended Use';

  @override
  String get disclaimerIntendedUseBody =>
      'Scores2Go is intended as an informational and educational reference tool for trained healthcare professionals. The application performs mathematical calculations based on published clinical scoring systems and user-entered values. It is not designed for, and must not be used as, the sole basis for clinical decision-making.';

  @override
  String get disclaimerRegulatoryTitle => 'Regulatory Status';

  @override
  String get disclaimerRegulatoryBody =>
      'Scores2Go is not intended to diagnose, predict, monitor, or treat disease. It is not a medical device within the meaning of Regulation (EU) 2017/745 (MDR). The application performs mathematical calculations only and presents results as score values without diagnostic conclusions, treatment recommendations, or clinical outcome predictions.';

  @override
  String get disclaimerNoAdviceTitle => 'No Medical Advice';

  @override
  String get disclaimerNoAdviceBody =>
      'Scores2Go does not provide medical advice, diagnoses, or treatment recommendations. Clinical decisions must not be based solely on results from this application. Users remain solely responsible for patient assessment, diagnosis, and all clinical decisions.';

  @override
  String get disclaimerAccuracyTitle => 'Accuracy & Liability';

  @override
  String get disclaimerAccuracyBody =>
      'Reasonable efforts have been made to implement scoring formulas accurately based on published scientific literature. However, no guarantee is made regarding completeness, correctness, or fitness for any specific purpose. The operators of Scores2Go shall not be liable for damages arising from use of this application, except in cases of intent, gross negligence, or where liability is mandatory under applicable law.';

  @override
  String get disclaimerPrivacyTitle => 'Data & Privacy';

  @override
  String get disclaimerPrivacyBody =>
      'Scores2Go does not collect, store, or transmit patient data. All score calculations are performed locally on your device. Only your account credentials (email address) are stored for authentication purposes. No health-related data is associated with your account.';
}
