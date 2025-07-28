// lib/pages/home_page.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../widgets/language_switcher.dart';
import '../core/theme.dart'; // kBlue/kTextBlack/kGreyTxt

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: _Body(loc: loc),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final AppLocalizations loc;
  const _Body({required this.loc});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/icons/logomyscan.png', width: 56, height: 56),
            Text(
              loc.appTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: kBlue,
              ),
            ),
            const LanguageSwitcher(),
          ],
        ),
        const SizedBox(height: 24),

        Text(
          loc.homeSelectModality,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: kTextBlack,
          ),
        ),
        const SizedBox(height: 10),

        Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: kGreyTxt,
            ),
            children: [
              TextSpan(text: loc.homeDescriptionPrefix),
              TextSpan(
                text: loc.homeDescriptionLink,
                style: const TextStyle(
                  color: kBlue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  // TODO: open link
                },
              ),
              TextSpan(text: loc.homeDescriptionSuffix),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // ── Плитки как раньше (ч/б изображение + белый заголовок) ───────────
        _ModalityButton(
          label: loc.homeLungs,
          img: 'assets/lungs.jpg',
          onTap: () => router.go('/modality/lungs'),
        ),
        const SizedBox(height: 14),
        _ModalityButton(
          label: loc.homeOct,
          img: 'assets/oct.jpg',
          onTap: () => router.go('/modality/oct'),
        ),
        const SizedBox(height: 14),
        _ModalityButton(
          label: loc.homeBrain,
          img: 'assets/brain.jpg',
          onTap: () => router.go('/modality/brain'),
        ),
      ],
    );
  }
}

class _ModalityButton extends StatelessWidget {
  final String label;
  final String img;
  final VoidCallback onTap;
  const _ModalityButton({
    required this.label,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18), // скругление как на скрине
        child: Stack(
          alignment: Alignment.center,
          children: [
            // фоновое изображение в ч/б
            ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0, // r
                0.2126, 0.7152, 0.0722, 0, 0, // g
                0.2126, 0.7152, 0.0722, 0, 0, // b
                0,      0,      0,      1, 0, // a
              ]),
              child: Image.asset(
                img,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // затемнение
            Container(color: Colors.black.withOpacity(.55)),
            // белая надпись
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: .5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
