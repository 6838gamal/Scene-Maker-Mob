import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final bgColor = isDark ? AppColors.background : AppColors.lightBackground;

    final contacts = [
      _ContactItem(
        icon: Icons.email_rounded,
        label: l10n.email,
        value: 'dev@scenemaker.app',
        colors: [const Color(0xFF4F46E5), const Color(0xFF7C3AED)],
        onTap: () => launchUrl(Uri.parse('mailto:dev@scenemaker.app')),
      ),
      _ContactItem(
        icon: Icons.send_rounded,
        label: l10n.telegram,
        value: '@SceneMakerApp',
        colors: [const Color(0xFF0088CC), const Color(0xFF00B4E4)],
        onTap: () => launchUrl(Uri.parse('https://t.me/SceneMakerApp')),
      ),
      _ContactItem(
        icon: Icons.chat_rounded,
        label: l10n.whatsapp,
        value: '+1 (555) 000-0000',
        colors: [const Color(0xFF25D366), const Color(0xFF128C7E)],
        onTap: () => launchUrl(Uri.parse('https://wa.me/15550000000')),
      ),
      _ContactItem(
        icon: Icons.language_rounded,
        label: l10n.website,
        value: 'www.scenemaker.app',
        colors: [const Color(0xFF7C3AED), const Color(0xFF06B6D4)],
        onTap: () => launchUrl(Uri.parse('https://www.scenemaker.app')),
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
          title: Text(l10n.contactUs, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header illustration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1C1C27), Color(0xFF13131A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.headset_mic_rounded, color: Colors.white, size: 34),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.contactUs,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.reachOut,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ...contacts.map((item) => _ContactTile(item: item, isDark: isDark)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;
  final List<Color> colors;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.onTap,
  });
}

class _ContactTile extends StatelessWidget {
  final _ContactItem item;
  final bool isDark;

  const _ContactTile({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.card : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: item.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(item.icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.value,
                    style: TextStyle(
                      color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isDark ? AppColors.textMuted : AppColors.lightTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
