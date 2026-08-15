import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/theme/app_colors.dart';
import 'package:scores_2_go/theme/theme_data.dart';

void main() {
  // Regression coverage for a bug where the "Sign in" SnackBarAction was
  // invisible in dark mode: with no explicit snackBarTheme, Flutter's M3
  // defaults resolve actionTextColor from ColorScheme.inversePrimary and the
  // background from ColorScheme.inverseSurface. Neither was set explicitly
  // in this app's ColorScheme, so both fell back (inversePrimary -> onPrimary,
  // inverseSurface -> onSurface) to the same white in the dark theme.
  group('SnackBarThemeData', () {
    test('dark theme: action text color differs from the SnackBar background', () {
      final snackBarTheme = AppTheme.dark().snackBarTheme;
      expect(snackBarTheme.backgroundColor, AppColors.darkTextPrimary); // white
      expect(snackBarTheme.actionTextColor, AppColors.blue);
      expect(snackBarTheme.actionTextColor, isNot(equals(snackBarTheme.backgroundColor)));
      expect(snackBarTheme.contentTextStyle?.color, AppColors.darkSurface);
    });

    test('light theme: action text color differs from the SnackBar background', () {
      final snackBarTheme = AppTheme.light().snackBarTheme;
      expect(snackBarTheme.backgroundColor, AppColors.lightTextPrimary);
      expect(snackBarTheme.actionTextColor, AppColors.teal);
      expect(snackBarTheme.actionTextColor, isNot(equals(snackBarTheme.backgroundColor)));
      expect(snackBarTheme.contentTextStyle?.color, AppColors.lightSurface);
    });
  });

  // End-to-end: pumps the exact SnackBar/SnackBarAction shape used by
  // ensureSignedIn() through a real widget tree on AppTheme.dark(), to prove
  // both the rendered contrast and the auto-dismiss timing, without
  // depending on AuthBloc/Supabase plumbing (irrelevant to this bug).
  //
  // Note: a SnackBar with a non-null `action` defaults `persist` to true,
  // which means it does NOT auto-dismiss on a timer at all (confirmed
  // against the Flutter SDK's own snack_bar_test.dart, which removes the
  // action specifically "because Snackbar with action doesn't timeout").
  // ensureSignedIn() must pass `persist: false` explicitly, which is what
  // this test guards.
  group('sign-in SnackBar end-to-end (dark theme)', () {
    Future<void> pumpSignInSnackbar(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Melde dich an, um Feedback zu senden.'),
                        action: SnackBarAction(label: 'Anmelden', onPressed: () {}),
                        duration: const Duration(seconds: 6),
                        persist: false,
                      ),
                    );
                  },
                  child: const Text('trigger'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('trigger'));
      await tester.pump(); // schedule entrance animation
      await tester.pump(const Duration(milliseconds: 250)); // entrance completes, arms dismiss timer
    }

    testWidgets('"Anmelden" renders in the branded blue, not white-on-white', (tester) async {
      await pumpSignInSnackbar(tester);

      expect(find.text('Anmelden'), findsOneWidget);
      final richText = tester.widget<RichText>(
        find
            .descendant(
              of: find.widgetWithText(TextButton, 'Anmelden'),
              matching: find.byType(RichText),
            )
            .first,
      );
      expect(richText.text.style?.color, AppColors.blue);
      expect(richText.text.style?.color, isNot(Colors.white));
    });

    testWidgets('auto-dismisses on its own after ~6s, with no tap on the action', (tester) async {
      await pumpSignInSnackbar(tester);
      expect(find.text('Anmelden'), findsOneWidget);

      // Still present comfortably before the 6000ms SnackBar duration elapses.
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 250));
      }
      expect(find.text('Anmelden'), findsOneWidget); // ~5250ms elapsed

      // Advance in small steps past the duration + exit animation. Large
      // single pump(duration) jumps are unreliable here because the dismiss
      // Timer and the reverse (exit) AnimationController are both driven by
      // the same fake clock, and a Timer firing mid-jump only gets whatever
      // time remains in that jump to also finish the reverse animation.
      // pumpAndSettle() alone doesn't help either: between the entrance
      // finishing and the Timer firing there's no scheduled frame, so it
      // returns immediately without elapsing enough fake time.
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 250));
      }
      expect(find.text('Anmelden'), findsNothing); // ~8250ms elapsed
    });
  });
}
