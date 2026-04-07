abstract class ScoreI10n {
  Map<String, Map<String, String>> get strings;

  String t(String locale, String key, {String fallbackLocale = 'en'}) {
    return strings[locale]?[key] ?? strings[fallbackLocale]?[key] ?? key;
  }
}
