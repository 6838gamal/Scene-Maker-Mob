import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final subColor = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
    final bgColor = isDark ? AppColors.background : AppColors.lightBackground;
    final cardColor = isDark ? AppColors.card : AppColors.lightCard;

    final releaseNotes = [
      _ReleaseNote(
        version: '1.0.0',
        date: 'May 2025',
        notes: [
          'AI recolor improvements — more accurate color matching',
          'Smart object tracking optimization',
          'Export system enhancements for all platforms',
          'Arabic RTL support fully implemented',
          'New cinematic style templates added',
        ],
      ),
      _ReleaseNote(
        version: '0.9.0 Beta',
        date: 'April 2025',
        notes: [
          'Initial beta release',
          'Core AI object selection engine',
          'Basic remove & replace functionality',
          'Dark mode foundation',
        ],
      ),
    ];

    return Directionality(
      textDirection: locale.textDirection,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(l10n.versionDetails, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Current version card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1C1C27), Color(0xFF13131A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.movie_filter, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Scene Maker',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _VersionBadge(label: l10n.version, value: '1.0.0'),
                        const SizedBox(width: 16),
                        _VersionBadge(label: l10n.buildNumber, value: '1'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.releaseNotes,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...releaseNotes.map((note) => _ReleaseNoteCard(note: note, isDark: isDark, cardColor: cardColor, textColor: textColor, subColor: subColor, l10n: l10n)),
            ],
          ),
        ),
      ),
    );
  }
}

class _VersionBadge extends StatelessWidget {
  final String label;
  final String value;

  const _VersionBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ReleaseNote {
  final String version;
  final String date;
  final List<String> notes;

  const _ReleaseNote({required this.version, required this.date, required this.notes});
}

class _ReleaseNoteCard extends StatelessWidget {
  final _ReleaseNote note;
  final bool isDark;
  final Color cardColor;
  final Color textColor;
  final Color subColor;
  final AppLocalizations l10n;

  const _ReleaseNoteCard({
    required this.note,
    required this.isDark,
    required this.cardColor,
    required this.textColor,
    required this.subColor,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${l10n.version} ${note.version}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              Text(note.date, style: TextStyle(color: subColor, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 14),
          ...note.notes.map((n) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7, right: 10),
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(n, style: TextStyle(color: textColor, fontSize: 13, height: 1.5)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
