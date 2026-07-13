import 'package:flutter/foundation.dart';

/// Captures a `?score=<name>` query parameter from the initial web URL so the
/// app can open that score automatically after authentication resolves.
///
/// On native platforms this is a no-op — deep links there require
/// AndroidManifest intent-filters / iOS Associated Domains, which is outside
/// the scope of the web launch flow.
class DeepLinkService {
  static String? _pendingScoreName;

  /// Call once, right after [WidgetsFlutterBinding.ensureInitialized],
  /// before [runApp].
  static void init() {
    if (!kIsWeb) return;
    final score = Uri.base.queryParameters['score'];
    if (score != null && score.isNotEmpty) {
      _pendingScoreName = score;
    }
  }

  /// Returns the pending score name and clears it. Returns null if no
  /// deep link was present in the launch URL.
  static String? consume() {
    final name = _pendingScoreName;
    _pendingScoreName = null;
    return name;
  }
}
