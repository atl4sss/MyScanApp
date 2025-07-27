// lib/pages/result_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';
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

/// Маппинг исходной метки модели → внутренний код
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
    case 'Без опухоли': // вариант с неразрывным пробелом
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

    // Локализованное имя диагноза
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

    // Краткое описание (есть только для некоторых диагнозов)
    String? brief;
    switch (code) {
      case 'pneumonia':
        brief = loc.diagPneumoniaBrief;
        break;
      case 'meningioma':
        brief = loc.diagMeningiomaBrief;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    loc.appTitle,
                    style: const TextStyle(
                      fontFamily: 'SamsungSharpSans',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: kBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // заголовок страницы
              Text(
                loc.resultTitle,
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: kTextBlack,
                ),
              ),
              const SizedBox(height: 20),

              // снимок
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(args.imgPath),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // диагноз + вероятность
              Text(
                loc.diagnosisProbability(diagName, percent),
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kTextBlack,
                ),
              ),

              // краткое описание
              if (brief != null) ...[
                const SizedBox(height: 10),
                Text(
                  brief,
                  style: const TextStyle(
                    fontFamily: 'Gothic',
                    fontSize: 15,
                    height: 1.4,
                    color: kTextBlack,
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // «таблетки» (есть тексты только для pneumonia/meningioma)
              if (code != null)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _pill(context, code, 'risks', loc),
                    _pill(context, code, 'prevention', loc),
                    _pill(context, code, 'contact', loc),
                    _pill(context, code, 'causes', loc),
                  ],
                ),
              const SizedBox(height: 32),

              // кнопка «назад»
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => context.go('/home'),
                  child: Text(
                    loc.backButton,
                    style: const TextStyle(
                      fontFamily: 'SamsungSharpSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _pill(
      BuildContext context, String code, String section, AppLocalizations loc) {
    final label = switch (section) {
      'risks' => loc.pillRisks,
      'prevention' => loc.pillPrevention,
      'contact' => loc.pillContact,
      'causes' => loc.pillCauses,
      _ => section,
    };
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showInfo(context, code, section, loc),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'SamsungSharpSans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showInfo(
      BuildContext context, String code, String section, AppLocalizations loc) {
    String text;
    switch (code) {
      case 'pneumonia':
        text = switch (section) {
          'risks' => loc.diagPneumoniaRisks,
          'prevention' => loc.diagPneumoniaPrevention,
          'contact' => loc.diagPneumoniaContact,
          'causes' => loc.diagPneumoniaCauses,
          _ => loc.infoUnavailable,
        };
        break;
      case 'meningioma':
        text = switch (section) {
          'risks' => loc.diagMeningiomaRisks,
          'prevention' => loc.diagMeningiomaPrevention,
          'contact' => loc.diagMeningiomaContact,
          'causes' => loc.diagMeningiomaCauses,
          _ => loc.infoUnavailable,
        };
        break;
      default:
        text = loc.infoUnavailable;
    }

    final title = switch (section) {
      'risks' => loc.pillRisks,
      'prevention' => loc.pillPrevention,
      'contact' => loc.pillContact,
      'causes' => loc.pillCauses,
      _ => '',
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SamsungSharpSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kTextBlack,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Gothic',
                  fontSize: 15,
                  height: 1.4,
                  color: kTextBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
