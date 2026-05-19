import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/ai_template.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/template_card.dart';
import 'editor_screen.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final categories = ['All', 'Style', 'AI'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<AiTemplate> _filtered(int index) {
    if (index == 0) return kTemplates;
    if (index == 1) return kTemplates.where((t) => t.category == 'style').toList();
    return kTemplates.where((t) => t.category == 'ai').toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final bgColor = isDark ? AppColors.background : AppColors.lightBackground;

    return Directionality(
      textDirection: locale.textDirection,
      child: Scaffold(
        backgroundColor: bgColor,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu_rounded, color: textColor),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
          title: Text(l10n.aiTemplates, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
          bottom: TabBar(
            controller: _tabController,
            onTap: (i) => setState(() {}),
            labelColor: AppColors.primary,
            unselectedLabelColor: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: categories.map((c) => Tab(text: c)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(categories.length, (i) {
            final templates = _filtered(i);
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: templates.length,
              itemBuilder: (context, index) => TemplateCard(
                template: templates[index],
                isArabic: locale.isArabic,
                onTap: () => _showTemplatePreview(context, l10n, templates[index], locale.isArabic),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showTemplatePreview(BuildContext context, AppLocalizations l10n, AiTemplate template, bool isArabic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: template.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(template.icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              isArabic ? template.nameAr : template.name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 6),
            Text(
              isArabic ? template.descriptionAr : template.description,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            if (template.isPremium) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Text(l10n.premiumPlan, style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditorScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: template.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    template.isPremium ? l10n.unlockPremium : 'Apply Template',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }
}
