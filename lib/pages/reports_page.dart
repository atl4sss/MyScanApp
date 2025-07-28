/* lib/pages/reports_page.dart */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';

// REMOVED: import '../core/theme.dart';
import '../l10n/app_localizations.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});
  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  XFile? _file;
  final _complaint = TextEditingController();
  bool _sending = false;

  Future<void> _pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _file = img);
  }

  @override
  void dispose() {
    _complaint.dispose();
    super.dispose();
  }

  Future<void> _sendReport() async {
    final loc = AppLocalizations.of(context)!;
    setState(() => _sending = true);
    try {
      // LEAVE: выбираем нужный файл по языку
      final lang = Localizations.localeOf(context).languageCode;
      final assetPath = (lang == 'en')
          ? 'assets/reports/med_report_en.pdf'
          : 'assets/reports/med_report_ru.pdf';

      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/med_report.pdf');
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.reportsOpenError(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final t = Theme.of(context).textTheme;       // CHANGED
    final c = Theme.of(context).colorScheme;     // CHANGED

    return Scaffold(                              // CHANGED
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Шапка ───────────────────────────────────
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

                // ── Заголовок ───────────────────────────────
                Text(
                  loc.reportsTitle,
                  style: t.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),

                // ── Подпись ─────────────────────────────────
                Text(
                  loc.reportsSubtitle,
                  style: t.bodyMedium?.copyWith(
                    color: c.onSurfaceVariant,
                    height: 1.40,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: c.outlineVariant),

                const SizedBox(height: 16),

                // ── Блок: прикрепить изображение ────────────
                Text(
                  loc.reportsPickImageTitle,
                  style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),

                Center(
                  child: FilledButton.tonal(             // CHANGED
                    onPressed: _pickImage,
                    style: FilledButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.attach_file, size: 26),
                  ),
                ),

                if (_file != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _file!.name,
                    style: t.bodySmall?.copyWith(color: c.onSurfaceVariant),
                  ),
                ],

                const SizedBox(height: 24),

                // ── Блок: жалобы ────────────────────────────
                Text(
                  loc.reportsComplaintsTitle,
                  style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),

                // CHANGED: полагаемся на InputDecorationTheme (мягко, без жёсткой рамки)
                TextField(
                  controller: _complaint,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: loc.reportsComplaintHint,
                  ),
                ),

                const SizedBox(height: 28),

                // ── Кнопка отправки ─────────────────────────
                Center(
                  child: SizedBox(
                    width: 200, height: 48,                 // CHANGED
                    child: FilledButton(                    // CHANGED
                      onPressed: _sending
                          ? null
                          : () {
                              if (_complaint.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loc.reportsEmptyError)),
                                );
                              } else {
                                _sendReport();
                              }
                            },
                      child: _sending
                          ? const SizedBox(
                              width: 20, height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(loc.reportsSubmitButton),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
