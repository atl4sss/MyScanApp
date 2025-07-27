// lib/main.dart
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

import 'l10n/app_localizations.dart';        // NEW: прямой импорт сгенерированного файла
import 'widgets/language_switcher.dart';      // NEW: если используешь переключатель

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

// CHANGED: StatelessWidget → StatefulWidget, чтобы уметь менять язык
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // чтобы из любого места вызвать смену языка
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;                         // NEW: текущая выбранная локаль

  void setLocale(Locale locale) {          // NEW: метод смены языка
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: kBlue,
        scaffoldBackgroundColor: const Color(0xFFF6F7FC),
        fontFamily: 'Gothic',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: kBlue,
          foregroundColor: Colors.white,
        ),
      ),

      // NEW: подключаем локализации напрямую
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale, // если null — используется системный язык

      routerConfig: _router,
    );
  }
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

/* ─── конфигурация go_router ───────────────────────────────────────── */
final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => BottomNav(child: child),
      routes: [
        GoRoute(path: '/home',    builder: (_, __) => const HomePage()),
        GoRoute(path: '/info',    builder: (_, __) => const InfoPage()),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsPage()),
        GoRoute(path: '/chat',    builder: (_, __) => const ChatPage()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
        GoRoute(
          path: '/modality/:type',
          builder: (_, st) => ModalityPage(type: st.pathParameters['type']!),
        ),
      ],
    ),
    GoRoute(
      path: '/result',
      pageBuilder: (ctx, st) => CustomTransitionPage(
        key  : st.pageKey,
        child: ResultPage(args: _argsFromState(st)),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    ),
  ],
);
