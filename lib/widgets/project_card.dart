import 'package:flutter/material.dart';
import '../models/project.dart';
import '../theme/app_colors.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onDelete,
  });

  Color _platformColor(String platform) {
    if (platform.contains('TikTok')) return const Color(0xFF00F2EA);
    if (platform.contains('Instagram')) return const Color(0xFFE1306C);
    if (platform.contains('YouTube')) return const Color(0xFFFF0000);
    return AppColors.primary;
  }

  IconData _platformIcon(String platform) {
    if (platform.contains('TikTok')) return Icons.music_note;
    if (platform.contains('Instagram')) return Icons.camera_alt;
    if (platform.contains('YouTube')) return Icons.play_circle;
    return Icons.video_library;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final subColor = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark ? AppColors.card : AppColors.lightCard;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.secondary.withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 40,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  // Duration badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        project.duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Platform icon
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _platformColor(project.platform).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _platformColor(project.platform).withOpacity(0.3),
                        ),
                      ),
                      child: Icon(
                        _platformIcon(project.platform),
                        size: 14,
                        color: _platformColor(project.platform),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, size: 11, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '${project.aiEdits} AI edits',
                        style: TextStyle(
                          color: subColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
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
