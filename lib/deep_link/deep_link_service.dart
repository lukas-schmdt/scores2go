import 'package:flutter/foundation.dart';

/// Captures query parameters from the initial web URL that the app acts on
/// after startup:
/// - `?score=<name>` — opens that score automatically after authentication
///   resolves.
/// - `?token_hash=<hash>&type=recovery` — a password-reset link from the
///   Supabase "Reset Password" email template, verified by AuthBloc.
/// - Whether the URL is a Supabase auth callback (`?code=…` or an
///   `error_description`), so AuthBloc can tell a failed callback apart from
///   unrelated auth errors such as a failed token refresh.
///
/// On native platforms this is a no-op — deep links there require
/// AndroidManifest intent-filters / iOS Associated Domains, which is outside
/// the scope of the web launch flow.
class DeepLinkService {
  static String? _pendingScoreName;
  static String? _pendingRecoveryTokenHash;
  static bool _pendingAuthCallback = false;

  /// Call once, right after [WidgetsFlutterBinding.ensureInitialized],
  /// before [runApp].
  static void init() {
    if (!kIsWeb) return;
    final params = Uri.base.queryParameters;

    final score = params['score'];
    if (score != null && score.isNotEmpty) {
      _pendingScoreName = score;
    }

    final tokenHash = params['token_hash'];
    if (params['type'] == 'recovery' &&
        tokenHash != null &&
        tokenHash.isNotEmpty) {
      _pendingRecoveryTokenHash = tokenHash;
    }

    _pendingAuthCallback =
        params.containsKey('code') ||
        Uri.base.toString().contains('error_description');
  }

  /// Returns the pending score name and clears it. Returns null if no
  /// deep link was present in the launch URL.
  static String? consume() {
    final name = _pendingScoreName;
    _pendingScoreName = null;
    return name;
  }

  /// Returns the pending password-recovery token hash and clears it. Returns
  /// null if the launch URL wasn't a recovery link.
  static String? consumeRecoveryTokenHash() {
    final hash = _pendingRecoveryTokenHash;
    _pendingRecoveryTokenHash = null;
    return hash;
  }

  /// Returns whether the launch URL was a Supabase auth callback, and clears
  /// the flag so only the first auth error after launch is attributed to it.
  static bool consumeAuthCallback() {
    final pending = _pendingAuthCallback;
    _pendingAuthCallback = false;
    return pending;
  }
}
