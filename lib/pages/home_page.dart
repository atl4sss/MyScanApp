import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart'; // NEW
import '../core/theme.dart';
import '../widgets/language_switcher.dart'; // NEW

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // NEW
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: _Body(loc: loc), // CHANGED
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final AppLocalizations loc; // NEW
  const _Body({required this.loc}); // NEW

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
            Text( // CHANGED
              loc.appTitle,
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: kBlue,
              ),
            ),
            const LanguageSwitcher(), // NEW (можно убрать если не нужно)
          ],
        ),
        const SizedBox(height: 28),

        Text( // CHANGED
          loc.homeSelectModality,
          style: const TextStyle(
            fontFamily: 'SamsungSharpSans',
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: kTextBlack,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 10),

        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontFamily: 'Gothic',
              fontSize: 14,
              color: kGreyTxt,
            ),
            children: [
              TextSpan(text: loc.homeDescriptionPrefix), // CHANGED
              TextSpan(
                text: loc.homeDescriptionLink, // CHANGED
                style: const TextStyle(
                  color: kBlue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  // TODO: открыть ссылку
                },
              ),
              TextSpan(text: loc.homeDescriptionSuffix), // CHANGED
            ],
          ),
        ),
        const SizedBox(height: 24),

        _ModalityButton(
          label: loc.homeLungs, // CHANGED
          img: 'assets/lungs.jpg',
          onTap: () => router.go('/modality/lungs'),
        ),
        const SizedBox(height: 16),
        _ModalityButton(
          label: loc.homeOct, // CHANGED
          img: 'assets/oct.jpg',
          onTap: () => router.go('/modality/oct'),
        ),
        const SizedBox(height: 16),
        _ModalityButton(
          label: loc.homeBrain, // CHANGED
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
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              img,
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.55),
              colorBlendMode: BlendMode.darken,
            ),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
