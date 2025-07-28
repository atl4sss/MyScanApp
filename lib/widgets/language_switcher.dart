// lib/widgets/language_switcher.dart
import 'package:flutter/material.dart';
import '../main.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;
    final c = Theme.of(context).colorScheme;

    return PopupMenuButton<String>(
      tooltip: 'Language',
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (code) => MyApp.of(context)?.setLocale(Locale(code)),
      itemBuilder: (context) => [
        _item(context, 'en', 'English', current == 'en'),
        _item(context, 'ru', 'Русский', current == 'ru'),
      ],
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: c.primary,                 // CHANGED: из темы
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(                        // CHANGED: без const, цвет из темы
          Icons.language,
          color: c.onPrimary,
          size: 22,
        ),
      ),
    );
  }

  PopupMenuItem<String> _item(
    BuildContext context,
    String code,
    String label,
    bool selected,
  ) {
    final c = Theme.of(context).colorScheme;  // CHANGED: цвет из темы
    return PopupMenuItem<String>(
      value: code,
      child: Row(
        children: [
          Expanded(child: Text(label)),
          if (selected) Icon(Icons.check, size: 18, color: c.primary),
        ],
      ),
    );
  }
}
