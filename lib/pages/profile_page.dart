/* lib/pages/profile_page.dart */
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../l10n/app_localizations.dart'; // NEW

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // NEW

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: ListView(
          children: [
            // логотип + MyScan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/logomyscan.png',
                    width: 56, height: 56),
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
            const SizedBox(height: 24),

            // заголовок «Профиль»
            Text(
              loc.profileTitle, // CHANGED
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: kTextBlack,
              ),
            ),
            const SizedBox(height: 28),

            // блок: аватар + имя + телефон
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kBlue.withOpacity(0.05),
                    border: Border.all(color: kBlue, width: 2),
                  ),
                  child: const Icon(Icons.person, size: 40, color: kBlue),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.profileNameValue, // CHANGED
                        style: const TextStyle(
                          fontFamily: 'SamsungSharpSans',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kTextBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc.profilePhoneValue, // CHANGED
                        style: const TextStyle(
                          fontFamily: 'Gothic',
                          fontSize: 18,
                          color: kTextBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loc.profileEmailValue, // CHANGED
                        style: const TextStyle(
                          fontFamily: 'Gothic',
                          fontSize: 15,
                          color: kGreyTxt,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Персональные данные
            sectionTitle(loc.profilePersonalDataTitle), // CHANGED
            _InfoRow(label: loc.profileDOBLabel, value: loc.profileDOBValue),
            _InfoRow(label: loc.profileAgeLabel, value: loc.profileAgeValue),
            _InfoRow(label: loc.profileGenderLabel, value: loc.profileGenderValue),
            _InfoRow(label: loc.profileAddressLabel, value: loc.profileAddressValue),
            const SizedBox(height: 28),

            // Медицинская информация
            sectionTitle(loc.profileMedicalInfoTitle), // CHANGED
            _InfoRow(label: loc.profileClinicLabel, value: loc.profileClinicValue),
            _InfoRow(label: loc.profileDoctorLabel, value: loc.profileDoctorValue),
            _InfoRow(label: loc.profileBloodGroupLabel, value: loc.profileBloodGroupValue),
            _InfoRow(label: loc.profileAllergiesLabel, value: loc.profileAllergiesValue),
            _InfoRow(label: loc.profileChronicDiseasesLabel, value: loc.profileChronicDiseasesValue),
            _InfoRow(label: loc.profileLastCheckupLabel, value: loc.profileLastCheckupValue),
            const SizedBox(height: 28),

            // Статистика MyScan
            sectionTitle(loc.profileStatsTitle), // CHANGED
            _StatsTable(loc: loc), // CHANGED
            const SizedBox(height: 28),

            // Страхование
            sectionTitle(loc.profileInsuranceTitle), // CHANGED
            _InfoRow(label: loc.profilePolicyLabel, value: loc.profilePolicyValue),
            _InfoRow(label: loc.profileValidUntilLabel, value: loc.profilePolicyValidUntilValue),
            const SizedBox(height: 28),

            // Экстренные контакты
            sectionTitle(loc.profileEmergencyContactsTitle), // CHANGED
            _InfoRow(label: loc.profileMotherLabel, value: loc.profileMotherValue),
            _InfoRow(label: loc.profileFatherLabel, value: loc.profileFatherValue),
            const SizedBox(height: 40),

            // кнопка «История сканов»
            Center(
              child: SizedBox(
                width: 190,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: kBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    // TODO: navigate to history
                  },
                  child: Text(
                    loc.profileHistoryButton, // CHANGED
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
    );
  }

  Widget sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'SamsungSharpSans',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: kTextBlack,
      ),
    ),
  );
}

// строка «Метка: значение»
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: 'Gothic',
            fontSize: 14,
            color: kTextBlack,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

// табличка статистики
class _StatsTable extends StatelessWidget {
  final AppLocalizations loc;
  const _StatsTable({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    final rows = [
      (loc.profileStatBrainMRI, '1', '08 Jan 2025'), // CHANGED (даты можно тоже локализовать)
      (loc.profileStatLungCT, '2', '15 Jun 2025'),
      (loc.profileStatRetinaOCT, '3', '02 Jul 2025'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: rows.map((e) {
          final (title, count, last) = e;
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontFamily: 'Gothic', fontSize: 14)),
                ),
                Text(count,
                    style: const TextStyle(
                        fontFamily: 'Gothic',
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(width: 16),
                Text(last,
                    style: const TextStyle(
                        fontFamily: 'Gothic',
                        color: kGreyTxt,
                        fontSize: 13)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
