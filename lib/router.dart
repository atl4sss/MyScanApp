import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/bottom_nav.dart';
import 'pages/home_page.dart';
import 'pages/info_page.dart';
import 'pages/reports_page.dart';
import 'pages/chat_page.dart';
import 'pages/profile_page.dart';
import 'pages/modality_page.dart';
import 'pages/result_page.dart';   // ← и ResultArgs здесь же

// ───────── helper: парсим extra или query из deep‑link ─────────
ResultArgs _argsFromState(GoRouterState st) {
  if (st.extra case final ResultArgs e) return e;

  final q = st.uri.queryParameters;
  return ResultArgs(
    imgPath    : q['img']  ?? '',
    diagnosis  : q['label']?? '—',
    probability: double.tryParse(q['prob'] ?? '') ?? 0.0,
  );
}

// ───────── сам роутер ─────────
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      // navigatorKey: _shellKey,               // (опц.) если нужен отдельный ключ
      builder: (_, __, child) => BottomNav(child: child),
      routes: [
        GoRoute(path: '/home',    builder: (_,__) => const HomePage()),
        GoRoute(path: '/info',    builder: (_,__) => const InfoPage()),
        GoRoute(path: '/reports', builder: (_,__) => const ReportsPage()),
        GoRoute(path: '/chat',    builder: (_,__) => const ChatPage()),
        GoRoute(path: '/profile', builder: (_,__) => const ProfilePage()),
        GoRoute(
          path: '/modality/:type',
          builder: (_, st) => ModalityPage(type: st.pathParameters['type']!),
        ),
      ],
    ),

    // экран результата БЕЗ навбара
    GoRoute(
      path: '/result',
      pageBuilder: (ctx, st) => CustomTransitionPage(
        key  : st.pageKey,
        child: ResultPage(args: _argsFromState(st)),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        // transitionDuration: const Duration(milliseconds: 250),
      ),
    ),
  ],
);

