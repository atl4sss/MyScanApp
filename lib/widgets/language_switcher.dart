// lib/widgets/language_switcher.dart
import 'package:flutter/material.dart';
import '../main.dart';
import '../core/theme.dart'; // kBlue

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;

    return PopupMenuButton<String>(
      tooltip: 'Language',
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (code) => MyApp.of(context)?.setLocale(Locale(code)),
      itemBuilder: (context) => [
        _item('en', 'English', current == 'en'),
        _item('ru', 'Русский', current == 'ru'),
      ],
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: kBlue, // СИНЯЯ КНОПКА
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
        child: const Icon(Icons.language, color: Colors.white, size: 22),
      ),
    );
  }

  PopupMenuItem<String> _item(String code, String label, bool selected) {
    return PopupMenuItem<String>(
      value: code,
      child: Row(
        children: [
          Expanded(child: Text(label)),
          if (selected) const Icon(Icons.check, size: 18, color: kBlue),
        ],
      ),
    );
  }
}
