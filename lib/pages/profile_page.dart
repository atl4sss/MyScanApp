/* lib/pages/profile_page.dart */
import 'package:flutter/material.dart';
// REMOVED: import '../core/theme.dart';
import '../l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final t = Theme.of(context).textTheme;       // CHANGED
    final c = Theme.of(context).colorScheme;     // CHANGED

    return Scaffold(                              // CHANGED: единообразно со всеми экранами
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: ListView(
            children: [
              // ── Шапка ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/logomyscan.png', width: 56, height: 56),
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

              // ── Заголовок страницы ────────────────────────
              Text(
                loc.profileTitle,
                style: t.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 28),

              // ── Аватар + ФИО + контакты ───────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: c.primaryContainer.withOpacity(.55),   // CHANGED
                      border: Border.all(color: c.outlineVariant),  // CHANGED
                    ),
                    child: Icon(Icons.person, size: 40, color: c.onPrimaryContainer),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.profileNameValue,
                          style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          loc.profilePhoneValue,
                          style: t.titleMedium?.copyWith(color: c.onSurface),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          loc.profileEmailValue,
                          style: t.bodyMedium?.copyWith(color: c.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ── Персональные данные ───────────────────────
              _SectionTitle(text: loc.profilePersonalDataTitle),                  // CHANGED
              _InfoRow(label: loc.profileDOBLabel,          value: loc.profileDOBValue),
              _InfoRow(label: loc.profileAgeLabel,          value: loc.profileAgeValue),
              _InfoRow(label: loc.profileGenderLabel,       value: loc.profileGenderValue),
              _InfoRow(label: loc.profileAddressLabel,      value: loc.profileAddressValue),
              const SizedBox(height: 28),

              // ── Медицинская информация ────────────────────
              _SectionTitle(text: loc.profileMedicalInfoTitle),                   // CHANGED
              _InfoRow(label: loc.profileClinicLabel,        value: loc.profileClinicValue),
              _InfoRow(label: loc.profileDoctorLabel,        value: loc.profileDoctorValue),
              _InfoRow(label: loc.profileBloodGroupLabel,    value: loc.profileBloodGroupValue),
              _InfoRow(label: loc.profileAllergiesLabel,     value: loc.profileAllergiesValue),
              _InfoRow(label: loc.profileChronicDiseasesLabel,value: loc.profileChronicDiseasesValue),
              _InfoRow(label: loc.profileLastCheckupLabel,   value: loc.profileLastCheckupValue),
              const SizedBox(height: 28),

              // ── Статистика MyScan ─────────────────────────
              _SectionTitle(text: loc.profileStatsTitle),                         // CHANGED
              _StatsTable(loc: loc),                                              // CHANGED
              const SizedBox(height: 28),

              // ── Страхование ───────────────────────────────
              _SectionTitle(text: loc.profileInsuranceTitle),                     // CHANGED
              _InfoRow(label: loc.profilePolicyLabel,       value: loc.profilePolicyValue),
              _InfoRow(label: loc.profileValidUntilLabel,   value: loc.profilePolicyValidUntilValue),
              const SizedBox(height: 28),

              // ── Экстренные контакты ───────────────────────
              _SectionTitle(text: loc.profileEmergencyContactsTitle),             // CHANGED
              _InfoRow(label: loc.profileMotherLabel,        value: loc.profileMotherValue),
              _InfoRow(label: loc.profileFatherLabel,        value: loc.profileFatherValue),
              const SizedBox(height: 40),

              // ── Кнопка «История сканов» ───────────────────
              Center(
                child: SizedBox(
                  width: 190, height: 44,                                      // CHANGED: 44 для M3
                  child: FilledButton(                                         // CHANGED: вместо Elevated
                    onPressed: () {
                      // TODO: navigate to history
                    },
                    child: Text(loc.profileHistoryButton),
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

// ── Заголовок секции (мягкая типографика темы) ─────────────────────────
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: t.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: c.onSurface,
        ),
      ),
    );
  }
}

// ── Строка «Метка: значение» ───────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final c = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: t.bodyLarge?.copyWith(color: c.onSurface, height: 1.35),
          children: [
            TextSpan(
              text: '$label: ',
              style: t.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

// ── Табличка статистики (мягкая карточка) ───────────────────────────────
class _StatsTable extends StatelessWidget {
  final AppLocalizations loc;
  const _StatsTable({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    final rows = [
      (loc.profileStatBrainMRI, '1', '08 Jan 2025'),
      (loc.profileStatLungCT, '2', '15 Jun 2025'),
      (loc.profileStatRetinaOCT, '3', '02 Jul 2025'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: c.surface,                                       // CHANGED
        borderRadius: BorderRadius.circular(16),                // CHANGED
        border: Border.all(color: c.outlineVariant),            // CHANGED
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rows[i].$1,
                      style: t.bodyLarge,
                    ),
                  ),
                  Text(
                    rows[i].$2,
                    style: t.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    rows[i].$3,
                    style: t.bodySmall?.copyWith(color: c.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            if (i != rows.length - 1)
              Divider(height: 1, color: c.outlineVariant),      // CHANGED
          ],
        ],
      ),
    );
  }
}
