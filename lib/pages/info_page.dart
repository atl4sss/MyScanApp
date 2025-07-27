/* lib/pages/info_page.dart */
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../l10n/app_localizations.dart'; // NEW

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  // NEW: идентификаторы разделов
  static const _ids = [
    'privacy',
    'photo',
    'diseases',
    'limitations',
    'faq',
    'validation',
    'about',
  ];

  String _currentId = 'privacy'; // CHANGED: был 'Конф.' теперь ID

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // NEW

    // NEW: маппер ID → локализованный заголовок
    String titleFor(String id) {
      switch (id) {
        case 'privacy':
          return loc.infoPrivacyTitle;
        case 'photo':
          return loc.infoPhotoTitle;
        case 'diseases':
          return loc.infoDiseasesTitle;
        case 'limitations':
          return loc.infoLimitationsTitle;
        case 'faq':
          return loc.infoFaqTitle;
        case 'validation':
          return loc.infoValidationTitle;
        case 'about':
          return loc.infoAboutTitle;
        default:
          return id;
      }
    }

    // NEW: маппер ID → текст
    String bodyFor(String id) {
      switch (id) {
        case 'privacy':
          return loc.infoPrivacyBody;
        case 'photo':
          return loc.infoPhotoBody;
        case 'diseases':
          return loc.infoDiseasesBody;
        case 'limitations':
          return loc.infoLimitationsBody;
        case 'faq':
          return loc.infoFaqBody;
        case 'validation':
          return loc.infoValidationBody;
        case 'about':
          return loc.infoAboutBody;
        default:
          return '';
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // шапка
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/logomyscan.png', width: 56),
                Text(
                  loc.appTitle, // CHANGED
                  style: const TextStyle(
                    fontFamily: 'SamsungSharpSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // заголовок страницы
            Text(
              loc.infoTitle, // CHANGED
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: kTextBlack,
              ),
            ),
            const SizedBox(height: 20),

            // меню + контент
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // левый столбец
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView(
                      children: _ids.map((id) {
                        final selected = id == _currentId;
                        final title = titleFor(id);
                        return InkWell(
                          onTap: () => setState(() => _currentId = id),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFD0D0D0)
                                  : Colors.transparent,
                              border: const Border(
                                bottom: BorderSide(width: .5, color: Colors.grey),
                              ),
                            ),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontFamily: 'SamsungSharpSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: selected ? kTextBlack : Colors.black54,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // правый столбец
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          bodyFor(_currentId), // CHANGED
                          style: const TextStyle(
                            fontFamily: 'Gothic',
                            fontSize: 14,
                            height: 1.35,
                            color: kTextBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
