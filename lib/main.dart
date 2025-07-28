/* lib/main.dart */
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'core/theme.dart';
import 'pages/bottom_nav.dart';
import 'pages/home_page.dart';
import 'pages/info_page.dart';
import 'pages/reports_page.dart';
import 'pages/profile_page.dart';
import 'pages/chat_page.dart';
import 'pages/modality_page.dart';
import 'pages/result_page.dart';

import 'l10n/app_localizations.dart';
import 'widgets/language_switcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

// CHANGED: Stateful, чтобы уметь менять язык
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyScan',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      // локализации
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      routerConfig: _router,
    );
  }
}

/* ────────────── NEW: единый аниматор переходов ──────────────
   Лёгкий сдвиг справа + плавное затухание (iOS‑like, но быстрое).
*/
CustomTransitionPage<T> _page<T>(Widget child) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.04, 0), // лёгкий сдвиг
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/* ─── helper: достать аргументы для /result ─────────────────────────── */
ResultArgs _argsFromState(GoRouterState st) {
  if (st.extra case final ResultArgs e) return e;
  final q = st.uri.queryParameters;
  return ResultArgs(
    imgPath    : q['img']  ?? '',
    diagnosis  : q['label']?? '—',
    probability: double.tryParse(q['prob'] ?? '') ?? 0.0,
  );
}

/* ─── GoRouter с плавными переходами ───────────────────────────────── */
final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => BottomNav(child: child),
      routes: [
        GoRoute(path: '/home',    pageBuilder: (_, __) => _page(const HomePage())),
        GoRoute(path: '/info',    pageBuilder: (_, __) => _page(const InfoPage())),
        GoRoute(path: '/reports', pageBuilder: (_, __) => _page(const ReportsPage())),
        GoRoute(path: '/chat',    pageBuilder: (_, __) => _page(const ChatPage())),
        GoRoute(path: '/profile', pageBuilder: (_, __) => _page(const ProfilePage())),
        GoRoute(
          path: '/modality/:type',
          pageBuilder: (_, st) => _page(
            ModalityPage(type: st.pathParameters['type']!),
          ),
        ),
      ],
    ),
    // Можно оставить отдельный стиль для result, но я тоже сделал fade+slide
    GoRoute(
      path: '/result',
      pageBuilder: (ctx, st) => _page(ResultPage(args: _argsFromState(st))),
    ),
  ],
);
