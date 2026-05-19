import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/ai_template.dart';
import '../models/project.dart';
import '../providers/locale_provider.dart';
import '../providers/project_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/project_card.dart';
import '../widgets/template_card.dart';
import '../widgets/gradient_button.dart';
import 'editor_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: locale.textDirection,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.background : AppColors.lightBackground,
        drawer: const AppDrawer(),
        body: CustomScrollView(
          slivers: [
            _HomeAppBar(isDark: isDark, l10n: l10n),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _NewProjectBanner(l10n: l10n),
                    const SizedBox(height: 32),
                    _RecentProjectsSection(l10n: l10n, locale: locale),
                    const SizedBox(height: 32),
                    _TemplatesSection(l10n: l10n, locale: locale),
                    const SizedBox(height: 32),
                    _TrendingStylesSection(l10n: l10n, locale: locale),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  final bool isDark;
  final AppLocalizations l10n;

  const _HomeAppBar({required this.isDark, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final subColor = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;

    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: isDark ? AppColors.background : AppColors.lightBackground,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu_rounded, color: textColor),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search_rounded, color: textColor),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 20),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(20, 88, 20, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                l10n.goodTimeOfDay(),
                style: TextStyle(color: subColor, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.readyToEdit,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewProjectBanner extends StatelessWidget {
  final AppLocalizations l10n;

  const _NewProjectBanner({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, anim, __) => const EditorScreen(),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
        ),
      ),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2D1B69), Color(0xFF0A0A0F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            // Background glow
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.08),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome, size: 12, color: AppColors.primaryLight),
                              const SizedBox(width: 5),
                              Text(
                                'AI-Powered',
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.newProject,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.tapToImport,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onAction;
  final bool isDark;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    this.onAction,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionLabel,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _RecentProjectsSection extends StatelessWidget {
  final AppLocalizations l10n;
  final LocaleProvider locale;

  const _RecentProjectsSection({required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: l10n.recentProjects,
          actionLabel: l10n.viewAll,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        if (projects.isEmpty)
          _EmptyState(l10n: l10n, isDark: isDark)
        else
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: projects.take(5).length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final project = projects[index];
                return SizedBox(
                  width: 150,
                  child: ProjectCard(
                    project: project,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditorScreen()),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;

  const _EmptyState({required this.l10n, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: isDark ? AppColors.card : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.video_library_outlined, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.noProjects,
            style: TextStyle(
              color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.noProjectsDesc,
            style: TextStyle(
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TemplatesSection extends StatelessWidget {
  final AppLocalizations l10n;
  final LocaleProvider locale;

  const _TemplatesSection({required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: l10n.aiTemplates,
          actionLabel: l10n.seeAll,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kTemplates.length,
            itemBuilder: (context, index) => TemplateCard(
              template: kTemplates[index],
              isArabic: locale.isArabic,
              isSmall: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditorScreen()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendingStylesSection extends StatelessWidget {
  final AppLocalizations l10n;
  final LocaleProvider locale;

  const _TrendingStylesSection({required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trendingTemplates = kTemplates.where((t) => !t.isPremium).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: l10n.trendingStyles,
          actionLabel: l10n.seeAll,
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: trendingTemplates.take(4).length,
          itemBuilder: (context, index) => TemplateCard(
            template: trendingTemplates[index],
            isArabic: locale.isArabic,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditorScreen()),
            ),
          ),
        ),
      ],
    );
  }
}
