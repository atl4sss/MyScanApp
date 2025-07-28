// lib/pages/result_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// REMOVED: import '../core/theme.dart';           // CHANGED: используем цвета/шрифты темы
import '../l10n/app_localizations.dart';

class ResultArgs {
  final String imgPath;
  final String diagnosis;
  final double probability;
  const ResultArgs({
    required this.imgPath,
    required this.diagnosis,
    required this.probability,
  });
}

/// Маппинг исходной метки модели → внутренний код (LEAVE)
String? _codeForDiagnosis(String diagnosis) {
  switch (diagnosis) {
    case 'Пневмония':
      return 'pneumonia';
    case 'Менингиома':
      return 'meningioma';
    case 'Глиома':
      return 'glioma';
    case 'Питуитарная':
    case 'Аденома гипофиза':
      return 'pituitary';
    case 'Норма':
      return 'normal';
    case 'Без опухоли':
    case 'Без опухоли':
      return 'noTumor';
    case 'CNV':
      return 'cnv';
    case 'DME':
      return 'dme';
    case 'Drusen':
      return 'drusen';
    default:
      return null;
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.args});
  final ResultArgs args;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final code = _codeForDiagnosis(args.diagnosis);
    final percent = (args.probability * 100).toStringAsFixed(1);

    // Локализованное имя диагноза (LEAVE)
    String diagName = args.diagnosis;
    switch (code) {
      case 'normal':
        diagName = loc.diagNormalName;
        break;
      case 'pneumonia':
        diagName = loc.diagPneumoniaName;
        break;
      case 'cnv':
        diagName = loc.diagCNVName;
        break;
      case 'dme':
        diagName = loc.diagDMEName;
        break;
      case 'drusen':
        diagName = loc.diagDrusenName;
        break;
      case 'glioma':
        diagName = loc.diagGliomaName;
        break;
      case 'meningioma':
        diagName = loc.diagMeningiomaName;
        break;
      case 'pituitary':
        diagName = loc.diagPituitaryName;
        break;
      case 'noTumor':
        diagName = loc.diagNoTumorName;
        break;
    }

    // Краткое описание (LEAVE)
    String? brief;
    switch (code) {
      case 'pneumonia':
        brief = loc.diagPneumoniaBrief;
        break;
      case 'meningioma':
        brief = loc.diagMeningiomaBrief;
        break;
    }

    // CHANGED: используем тему
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;

    return Scaffold( // CHANGED: фон берём из темы
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Шапка ───────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/logomyscan.png', width: 56),
                  Text(
                    loc.appTitle,
                    style: t.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: c.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Заголовок страницы ─────────────────────────
              Text(
                loc.resultTitle,
                style: t.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 20),

              // ── Снимок ─────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(16), // CHANGED: мягкий радиус
                child: Image.file(
                  File(args.imgPath),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // ── Диагноз + вероятность ──────────────────────
              Text(
                loc.diagnosisProbability(diagName, percent),
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),

              // ── Краткое описание (если есть) ───────────────
              if (brief != null) ...[
                const SizedBox(height: 10),
                Text(
                  brief!,
                  style: t.bodyLarge?.copyWith(
                    height: 1.40,
                    color: c.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // ── «Пиллы» (мягкие кнопки) ────────────────────
              if (code != null)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _pill(context, code, 'risks',       loc),
                    _pill(context, code, 'prevention',  loc),
                    _pill(context, code, 'contact',     loc),
                    _pill(context, code, 'causes',      loc),
                  ],
                ),
              const SizedBox(height: 32),

              // ── Кнопка «Назад» ─────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(                       // CHANGED: FilledButton вместо Elevated
                  onPressed: () => context.go('/home'),
                  child: Text(loc.backButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // CHANGED: мягкая «таблетка» на основе темы
  Widget _pill(
    BuildContext context,
    String code,
    String section,
    AppLocalizations loc,
  ) {
    final c = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    final label = switch (section) {
      'risks'       => loc.pillRisks,
      'prevention'  => loc.pillPrevention,
      'contact'     => loc.pillContact,
      'causes'      => loc.pillCauses,
      _             => section,
    };

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showInfo(context, code, section, loc),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: c.primaryContainer,                     // CHANGED
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: t.labelLarge?.copyWith(
            color: c.onPrimaryContainer,                 // CHANGED
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showInfo(
    BuildContext context,
    String code,
    String section,
    AppLocalizations loc,
  ) {
    String text;
    switch (code) {
      case 'pneumonia':
        text = switch (section) {
          'risks'       => loc.diagPneumoniaRisks,
          'prevention'  => loc.diagPneumoniaPrevention,
          'contact'     => loc.diagPneumoniaContact,
          'causes'      => loc.diagPneumoniaCauses,
          _             => loc.infoUnavailable,
        };
        break;
      case 'meningioma':
        text = switch (section) {
          'risks'       => loc.diagMeningiomaRisks,
          'prevention'  => loc.diagMeningiomaPrevention,
          'contact'     => loc.diagMeningiomaContact,
          'causes'      => loc.diagMeningiomaCauses,
          _             => loc.infoUnavailable,
        };
        break;
      default:
        text = loc.infoUnavailable;
    }

    final title = switch (section) {
      'risks'       => loc.pillRisks,
      'prevention'  => loc.pillPrevention,
      'contact'     => loc.pillContact,
      'causes'      => loc.pillCauses,
      _             => '',
    };

    final t = Theme.of(context).textTheme;          // CHANGED: тема
    final c = Theme.of(context).colorScheme;        // CHANGED

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface, // CHANGED
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (_, scrollCtl) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: ListView(
            controller: scrollCtl,
            children: [
              // «ручка»
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: c.outlineVariant,               // CHANGED
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                title,
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text(
                text,
                style: t.bodyLarge?.copyWith(
                  height: 1.40,
                  color: c.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
