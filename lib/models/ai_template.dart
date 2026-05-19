import 'package:flutter/material.dart';

class AiTemplate {
  final String id;
  final String name;
  final String nameAr;
  final String description;
  final String descriptionAr;
  final IconData icon;
  final List<Color> gradient;
  final bool isPremium;
  final String category;

  const AiTemplate({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.description,
    required this.descriptionAr,
    required this.icon,
    required this.gradient,
    required this.isPremium,
    required this.category,
  });
}

final List<AiTemplate> kTemplates = [
  AiTemplate(
    id: '1',
    name: 'Cinematic',
    nameAr: 'سينمائي',
    description: 'Hollywood-grade cinematic look',
    descriptionAr: 'مظهر سينمائي بجودة هوليوود',
    icon: Icons.movie_filter,
    gradient: [const Color(0xFF7C3AED), const Color(0xFF3B82F6)],
    isPremium: false,
    category: 'style',
  ),
  AiTemplate(
    id: '2',
    name: 'Luxury',
    nameAr: 'فاخر',
    description: 'Gold & black premium aesthetic',
    descriptionAr: 'جمالية فاخرة ذهبية وداكنة',
    icon: Icons.diamond,
    gradient: [const Color(0xFFD4AF37), const Color(0xFFF59E0B)],
    isPremium: true,
    category: 'style',
  ),
  AiTemplate(
    id: '3',
    name: 'Horror',
    nameAr: 'رعب',
    description: 'Dark & eerie atmosphere',
    descriptionAr: 'جو داكن ومخيف',
    icon: Icons.nightlight,
    gradient: [const Color(0xFF1F1F1F), const Color(0xFF7F1D1D)],
    isPremium: false,
    category: 'style',
  ),
  AiTemplate(
    id: '4',
    name: 'Tech',
    nameAr: 'تقني',
    description: 'Futuristic digital aesthetic',
    descriptionAr: 'جماليات رقمية مستقبلية',
    icon: Icons.memory,
    gradient: [const Color(0xFF06B6D4), const Color(0xFF0EA5E9)],
    isPremium: false,
    category: 'style',
  ),
  AiTemplate(
    id: '5',
    name: 'Vintage',
    nameAr: 'كلاسيكي',
    description: 'Warm retro film look',
    descriptionAr: 'مظهر فيلمي دافئ وكلاسيكي',
    icon: Icons.camera,
    gradient: [const Color(0xFF92400E), const Color(0xFFD97706)],
    isPremium: true,
    category: 'style',
  ),
  AiTemplate(
    id: '6',
    name: 'Motivational',
    nameAr: 'تحفيزي',
    description: 'Bold, high-energy edits',
    descriptionAr: 'تعديلات جريئة وعالية الطاقة',
    icon: Icons.bolt,
    gradient: [const Color(0xFFEF4444), const Color(0xFFEC4899)],
    isPremium: false,
    category: 'style',
  ),
  AiTemplate(
    id: '7',
    name: 'Dark Aesthetic',
    nameAr: 'جماليات داكنة',
    description: 'Moody, artistic dark tones',
    descriptionAr: 'ألوان فنية داكنة',
    icon: Icons.dark_mode,
    gradient: [const Color(0xFF1E1B4B), const Color(0xFF312E81)],
    isPremium: true,
    category: 'style',
  ),
  AiTemplate(
    id: '8',
    name: 'Auto Captions',
    nameAr: 'ترجمة تلقائية',
    description: 'TikTok-style animated subtitles',
    descriptionAr: 'ترجمة متحركة بأسلوب تيك توك',
    icon: Icons.closed_caption,
    gradient: [const Color(0xFF10B981), const Color(0xFF059669)],
    isPremium: false,
    category: 'ai',
  ),
];
