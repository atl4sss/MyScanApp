/* lib/pages/info_page.dart */
import 'package:flutter/material.dart';
import '../core/theme.dart';                 // kPrimaryGradient
import '../l10n/app_localizations.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  static const _ids = [
    'privacy',
    'photo',
    'diseases',
    'limitations',
    'faq',
    'validation',
    'about',
  ];

  String _currentId = 'privacy';

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;

    String titleFor(String id) {
      switch (id) {
        case 'privacy':     return loc.infoPrivacyTitle;
        case 'photo':       return loc.infoPhotoTitle;
        case 'diseases':    return loc.infoDiseasesTitle;
        case 'limitations': return loc.infoLimitationsTitle;
        case 'faq':         return loc.infoFaqTitle;
        case 'validation':  return loc.infoValidationTitle;
        case 'about':       return loc.infoAboutTitle;
        default:            return id;
      }
    }

    String bodyFor(String id) {
      switch (id) {
        case 'privacy':     return loc.infoPrivacyBody;
        case 'photo':       return loc.infoPhotoBody;
        case 'diseases':    return loc.infoDiseasesBody;
        case 'limitations': return loc.infoLimitationsBody;
        case 'faq':         return loc.infoFaqBody;
        case 'validation':  return loc.infoValidationBody;
        case 'about':       return loc.infoAboutBody;
        default:            return '';
      }
    }

    Widget contentCard(String id) => AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      child: Container(
        key: ValueKey(id),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          bodyFor(id),
          style: t.bodyLarge?.copyWith(height: 1.45, color: c.onSurface),
        ),
      ),
    );

    Widget banner = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: kPrimaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 46, height: 46,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.info_outline, color: c.primary, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              loc.infoTitle,
              style: t.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: LayoutBuilder(
            builder: (ctx, cons) {
              final isWide = cons.maxWidth >= 720;

              final header = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/icons/logomyscan.png', width: 56),
                      Text(
                        loc.appTitle,
                        style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: c.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  banner,
                  const SizedBox(height: 16),
                ],
              );

              if (!isWide) {
                final idx = _ids.indexOf(_currentId);
                return DefaultTabController(
                  length: _ids.length,
                  initialIndex: idx < 0 ? 0 : idx,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header,
                      Container(
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: c.outlineVariant),
                        ),
                        child: TabBar(
                          isScrollable: true,
                          onTap: (i) => setState(() => _currentId = _ids[i]),
                          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                          indicator: BoxDecoration(
                            color: c.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelColor: c.onSecondaryContainer,
                          unselectedLabelColor: c.onSurfaceVariant,
                          tabs: _ids.map((id) => Tab(text: titleFor(id))).toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          children: _ids
                              .map((id) => SingleChildScrollView(child: contentCard(id)))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Широкие экраны: меню слева + контент
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: c.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: c.outlineVariant),
                          ),
                          child: ListView.separated(
                            itemCount: _ids.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: c.outlineVariant),
                            itemBuilder: (_, i) {
                              final id = _ids[i];
                              final selected = id == _currentId;
                              return ListTile(
                                onTap: () => setState(() => _currentId = id),
                                title: Text(
                                  titleFor(id),
                                  style: t.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: selected ? c.onSecondaryContainer : c.onSurfaceVariant,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: selected ? c.primary : c.outlineVariant,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                tileColor: selected ? c.secondaryContainer : null,
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: SingleChildScrollView(child: contentCard(_currentId))),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
