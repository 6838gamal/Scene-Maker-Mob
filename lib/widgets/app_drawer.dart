import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';
import '../screens/home_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/templates_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/version_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final subColor = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;

    return Drawer(
      width: 280,
      backgroundColor: isDark ? AppColors.surface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, isDark, textColor, subColor, l10n),
            const SizedBox(height: 8),
            Divider(color: isDark ? Colors.white.withOpacity(0.08) : Colors.grey.withOpacity(0.15), height: 1),
            const SizedBox(height: 8),
            // Menu items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
                  _DrawerItem(
                    icon: Icons.home_rounded,
                    label: l10n.home,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (r) => false,
                      );
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.video_library_rounded,
                    label: l10n.myProjects,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ProjectsScreen()));
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    label: l10n.aiTemplates,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const TemplatesScreen()));
                    },
                  ),
                  const SizedBox(height: 8),
                  Divider(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.12), height: 1),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.contact_support_rounded,
                    label: l10n.contactDeveloper,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ContactScreen()));
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.feedback_rounded,
                    label: l10n.leaveFeedback,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const FeedbackScreen()));
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.info_rounded,
                    label: l10n.versionDetails,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const VersionScreen()));
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.settings_rounded,
                    label: l10n.settings,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    },
                  ),
                ],
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Premium Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.diamond, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Scene Maker Pro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                l10n.upgradeToPremium,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Scene Maker v1.0.0',
                    style: TextStyle(
                      color: isDark ? AppColors.textMuted : AppColors.lightTextSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color textColor, Color subColor, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.movie_filter, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appName,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        l10n.freePlan,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final Color? color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.isActive = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = color ?? (isActive ? AppColors.primary : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary));
    final textColor = color ?? (isActive ? AppColors.primary : (isDark ? AppColors.textPrimary : AppColors.lightTextPrimary));

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
