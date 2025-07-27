/* lib/pages/reports_page.dart */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';

import '../core/theme.dart';
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
      // NEW: выбираем нужный файл по языку
      final lang = Localizations.localeOf(context).languageCode;
      final assetPath = (lang == 'en')
          ? 'assets/reports/med_report_en.pdf'
          : 'assets/reports/med_report_ru.pdf';

      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/med_report.pdf'); // имя во временной папке
      await file.writeAsBytes(bytes, flush: true);

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.reportsOpenError(e.toString()))),
      );
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // логотип + название
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/logomyscan.png', width: 56),
                  Text(
                    loc.appTitle,
                    style: const TextStyle(
                      fontFamily: 'SamsungSharpSans',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // заголовок
              Text(
                loc.reportsTitle,
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: kTextBlack,
                ),
              ),
              const SizedBox(height: 8),

              // подпись
              Text(
                loc.reportsSubtitle,
                style: const TextStyle(
                  fontFamily: 'Gothic',
                  fontSize: 14,
                  color: kGreyTxt,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(),

              const SizedBox(height: 12),
              Text(
                loc.reportsPickImageTitle,
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kTextBlack,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.attach_file,
                      color: Colors.white, size: 28),
                ),
              ),
              if (_file != null) ...[
                const SizedBox(height: 10),
                Text(
                  _file!.name,
                  style: const TextStyle(
                    fontFamily: 'Gothic',
                    fontSize: 14,
                    color: kGreyTxt,
                  ),
                ),
              ],

              const SizedBox(height: 24),
              Text(
                loc.reportsComplaintsTitle,
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kTextBlack,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black54, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _complaint,
                  maxLines: 6,
                  style: const TextStyle(
                    fontFamily: 'Gothic',
                    fontSize: 14,
                    color: kTextBlack,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: loc.reportsComplaintHint,
                  ),
                ),
              ),

              const SizedBox(height: 28),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: (_sending)
                        ? null
                        : () {
                      if (_complaint.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loc.reportsEmptyError),
                          ),
                        );
                      } else {
                        _sendReport();
                      }
                    },
                    child: _sending
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      loc.reportsSubmitButton,
                      style: const TextStyle(
                        fontFamily: 'SamsungSharpSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
