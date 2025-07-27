// lib/pages/modality_page.dart
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../core/inference.dart';
import '../core/theme.dart';
import 'result_page.dart';
import '../l10n/app_localizations.dart'; // NEW
import '../widgets/language_switcher.dart'; // опционально, если нужен переключатель

// CHANGED: убираем текстовые строки из карты — оставляем только asset
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
      final loc = AppLocalizations.of(context)!; // NEW
      setState(() => _err = loc.analysisError(e.toString())); // CHANGED
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // NEW

    // CHANGED: выбираем строки по type через switch
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // логотип + имя + (опц.) переключатель
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/logomyscan.png', width: 56),
                Text(
                  loc.appTitle, // CHANGED
                  style: const TextStyle(
                    fontFamily: 'SamsungSharpSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: kBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // заголовок
            Text(
              title, // CHANGED
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: kTextBlack,
              ),
            ),
            const SizedBox(height: 4),

            // подпись‑ссылка
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontFamily: 'Gothic',
                  fontSize: 13,
                  color: kGreyTxt,
                ),
                children: [
                  TextSpan(text: hintPrefix), // CHANGED
                  TextSpan(
                    text: hintLink, // CHANGED
                    style: const TextStyle(
                      color: kBlue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(text: hintSuffix), // CHANGED
                ],
              ),
            ),
            const SizedBox(height: 16),

            // превью картинки
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kBlue, width: 2),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(asset, height: 180, fit: BoxFit.cover), // CHANGED
            ),
            const SizedBox(height: 16),
            const Divider(),

            Text(
              loc.attachPhotoTitle, // CHANGED
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kTextBlack,
              ),
            ),
            const SizedBox(height: 16),

            // кнопка‑скрепка
            Center(
              child: GestureDetector(
                onTap: _busy ? null : _pick,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: _busy
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.attach_file,
                          size: 34,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            if (_picked != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    _picked!.name,
                    style: const TextStyle(
                      fontFamily: 'Gothic',
                      fontSize: 13,
                      color: kGreyTxt,
                    ),
                  ),
                ),
              ),
            if (_err != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _err!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
            const Spacer(),

            // кнопка «Анализ»
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: (_bytes == null || _busy) ? null : _analyse,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: _busy
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : Text(loc.analyzeButton), // CHANGED
              ),
            ),
          ],
        ),
      ),
    );
  }
}
