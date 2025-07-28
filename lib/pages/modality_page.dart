// lib/pages/modality_page.dart
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../core/inference.dart';
import 'result_page.dart';
import '../l10n/app_localizations.dart';
// REMOVED: import '../core/theme.dart';  // CHANGED: больше не нужен, используем Theme.of
// REMOVED: import '../widgets/language_switcher.dart'; // не используется на странице

// LEAVE: карта ассетов
const _assets = <String, String>{
  'lungs': 'assets/lungs.jpg',
  'oct': 'assets/oct.jpg',
  'brain': 'assets/brain.jpg',
};

class ModalityPage extends StatefulWidget {
  const ModalityPage({super.key, required this.type});
  final String type; // lungs / oct / brain

  @override
  State<ModalityPage> createState() => _ModalityPageState();
}

class _ModalityPageState extends State<ModalityPage> {
  XFile? _picked;
  Uint8List? _bytes;
  bool _busy = false;
  String? _err;

  Future<void> _pick() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;
    setState(() => _busy = true);
    final data = await img.readAsBytes();
    setState(() {
      _picked = img;
      _bytes = data;
      _busy = false;
      _err = null;
    });
  }

  Future<void> _analyse() async {
    if (_bytes == null) return;
    setState(() {
      _busy = true;
      _err = null;
    });

    try {
      final (label, prob) = await LocalAI().predict(widget.type, _bytes!);
      if (!mounted) return;
      context.go(
        '/result',
        extra: ResultArgs(
          imgPath: _picked!.path,
          diagnosis: label,
          probability: prob,
        ),
      );
    } catch (e) {
      final loc = AppLocalizations.of(context)!;
      setState(() => _err = loc.analysisError(e.toString()));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // CHANGED: все строки/ассеты выбираем как у вас, только далее стилизуем темой
    late final String title;
    late final String hintPrefix;
    late final String hintLink;
    late final String hintSuffix;
    late final String asset;

    switch (widget.type) {
      case 'lungs':
        title = loc.modalityLungsTitle;
        hintPrefix = loc.modalityLungsHintPrefix;
        hintLink = loc.modalityLungsHintLink;
        hintSuffix = loc.modalityLungsHintSuffix;
        asset = _assets['lungs']!;
        break;
      case 'oct':
        title = loc.modalityOctTitle;
        hintPrefix = loc.modalityOctHintPrefix;
        hintLink = loc.modalityOctHintLink;
        hintSuffix = loc.modalityOctHintSuffix;
        asset = _assets['oct']!;
        break;
      case 'brain':
        title = loc.modalityBrainTitle;
        hintPrefix = loc.modalityBrainHintPrefix;
        hintLink = loc.modalityBrainHintLink;
        hintSuffix = loc.modalityBrainHintSuffix;
        asset = _assets['brain']!;
        break;
      default:
        throw ArgumentError('Unknown modality: ${widget.type}');
    }

    final t = Theme.of(context).textTheme;       // CHANGED
    final c = Theme.of(context).colorScheme;     // CHANGED

    return Scaffold(                               // NEW: единообразно со всеми экранами
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Хедер ───────────────────────────────────────
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
              const SizedBox(height: 12),

              // ── Заголовок ───────────────────────────────────
              Text(
                title,
                style: t.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),

              // ── Подпись со ссылкой ─────────────────────────
              Text.rich(
                TextSpan(
                  style: t.bodySmall?.copyWith(color: c.onSurfaceVariant),
                  children: [
                    TextSpan(text: hintPrefix),
                    TextSpan(
                      text: hintLink,
                      style: t.bodySmall?.copyWith(
                        color: c.primary,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // TODO: открыть ссылку
                      },
                    ),
                    TextSpan(text: hintSuffix),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Превью образца снимка ──────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(16),     // CHANGED: мягкий радиус
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: c.outlineVariant), // CHANGED: тонкая обводка темы
                  ),
                  child: Image.asset(
                    asset,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),

              // ── Заголовок "Attach a photo" ─────────────────
              Text(
                loc.attachPhotoTitle,
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),

              // ── Кнопка-скрепка (мягкая) ────────────────────
              Center(
                child: FilledButton.tonal(
                  onPressed: _busy ? null : _pick,          // CHANGED
                  style: FilledButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(22),
                  ),
                  child: _busy
                      ? const SizedBox(
                          width: 26, height: 26,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                      : const Icon(Icons.attach_file, size: 28),
                ),
              ),

              if (_picked != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      _picked!.name,
                      style: t.bodySmall?.copyWith(color: c.onSurfaceVariant),
                    ),
                  ),
                ),

              if (_err != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _err!,
                    style: t.bodySmall?.copyWith(color: c.error),
                  ),
                ),

              const Spacer(),

              // ── Кнопка "Analyze" (первичная) ───────────────
              SizedBox(
                width: double.infinity,
                height: 48,                                   // CHANGED: чуть выше, мягче
                child: FilledButton(
                  onPressed: (_bytes == null || _busy) ? null : _analyse,
                  child: _busy
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                        )
                      : Text(loc.analyzeButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
