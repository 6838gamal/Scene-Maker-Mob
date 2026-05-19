import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/project_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/project_card.dart';
import 'editor_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final projects = context.watch<ProjectProvider>().projects;
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
          title: Text(l10n.myProjects, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
          actions: [
            PopupMenuButton<int>(
              icon: Icon(Icons.sort_rounded, color: textColor),
              color: isDark ? AppColors.card : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: (v) => setState(() => _sortIndex = v),
              itemBuilder: (_) => [
                PopupMenuItem(value: 0, child: Text(l10n.get('newest'), style: TextStyle(color: textColor))),
                PopupMenuItem(value: 1, child: Text(l10n.get('oldest'), style: TextStyle(color: textColor))),
                PopupMenuItem(value: 2, child: Text(l10n.get('duration'), style: TextStyle(color: textColor))),
              ],
            ),
          ],
        ),
        body: projects.isEmpty
            ? _buildEmpty(context, l10n, isDark)
            : Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) => ProjectCard(
                    project: projects[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditorScreen()),
                    ),
                    onDelete: () => _confirmDelete(context, l10n, projects[index].id),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, AppLocalizations l10n, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.video_library_outlined, color: AppColors.primary, size: 48),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.noProjects,
            style: TextStyle(
              color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noProjectsDesc,
            style: TextStyle(
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditorScreen())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(l10n.newProject, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.deleteProject, style: const TextStyle(color: Colors.white)),
        content: Text(l10n.deleteConfirm, style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProjectProvider>().removeProject(id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
