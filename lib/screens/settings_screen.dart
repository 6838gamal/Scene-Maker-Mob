import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _autoSave = true;
  int _exportQuality = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final bgColor = isDark ? AppColors.background : AppColors.lightBackground;

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
          title: Text(l10n.settings, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _SectionTitle(title: l10n.language, isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              child: Column(
                children: [
                  _RadioTile(
                    label: l10n.english,
                    icon: '🇬🇧',
                    isSelected: !locale.isArabic,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => locale.setLocale(const Locale('en')),
                  ),
                  _Divider(isDark: isDark),
                  _RadioTile(
                    label: l10n.arabic,
                    icon: '🇸🇦',
                    isSelected: locale.isArabic,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => locale.setLocale(const Locale('ar')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SectionTitle(title: l10n.theme, isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              child: Column(
                children: [
                  _RadioTile(
                    label: l10n.darkMode,
                    icon: '🌙',
                    isSelected: themeProvider.themeMode == AppThemeMode.dark,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => themeProvider.setThemeMode(AppThemeMode.dark),
                  ),
                  _Divider(isDark: isDark),
                  _RadioTile(
                    label: l10n.lightMode,
                    icon: '☀️',
                    isSelected: themeProvider.themeMode == AppThemeMode.light,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => themeProvider.setThemeMode(AppThemeMode.light),
                  ),
                  _Divider(isDark: isDark),
                  _RadioTile(
                    label: l10n.systemDefault,
                    icon: '⚙️',
                    isSelected: themeProvider.themeMode == AppThemeMode.system,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => themeProvider.setThemeMode(AppThemeMode.system),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SectionTitle(title: l10n.exportQualitySet, isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              child: Column(
                children: [
                  _RadioTile(
                    label: '1080p — Full HD',
                    icon: '📱',
                    isSelected: _exportQuality == 0,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => setState(() => _exportQuality = 0),
                  ),
                  _Divider(isDark: isDark),
                  _RadioTile(
                    label: '4K — Ultra HD ✦ Pro',
                    icon: '🎬',
                    isSelected: _exportQuality == 1,
                    isDark: isDark,
                    textColor: textColor,
                    onTap: () => setState(() => _exportQuality = 1),
                    accent: AppColors.accent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SectionTitle(title: 'Preferences', isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              child: Column(
                children: [
                  _SwitchTile(
                    label: l10n.notifications,
                    icon: Icons.notifications_outlined,
                    value: _notifications,
                    isDark: isDark,
                    textColor: textColor,
                    onChanged: (v) => setState(() => _notifications = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    label: l10n.autoSave,
                    icon: Icons.save_outlined,
                    value: _autoSave,
                    isDark: isDark,
                    textColor: textColor,
                    onChanged: (v) => setState(() => _autoSave = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  const Text('Scene Maker', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('Version 1.0.0 (Build 1)', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text('© 2025 Scene Maker', style: TextStyle(color: AppColors.textMuted.withOpacity(0.6), fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: isDark ? AppColors.textMuted : AppColors.lightTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const _SettingsCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.card : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.12),
        ),
      ),
      child: child,
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;

  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.1),
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final bool isDark;
  final Color textColor;
  final VoidCallback onTap;
  final Color? accent;

  const _RadioTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.textColor,
    required this.onTap,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final color = accent ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? color : Colors.transparent,
                border: Border.all(
                  color: isSelected ? color : (isDark ? Colors.white.withOpacity(0.2) : Colors.grey.withOpacity(0.4)),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final bool isDark;
  final Color textColor;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.label,
    required this.icon,
    required this.value,
    required this.isDark,
    required this.textColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
          const SizedBox(width: 14),
          Expanded(
            child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 14)),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
