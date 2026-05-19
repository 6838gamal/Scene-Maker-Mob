import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/ai_action_menu.dart';
import '../widgets/glass_card.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen>
    with TickerProviderStateMixin {
  int _currentTab = 0;
  bool _showAiMenu = false;
  Offset _aiMenuPosition = Offset.zero;
  String? _selectedAction;
  bool _isProcessing = false;
  bool _isPlaying = false;
  double _progress = 0.35;
  String? _selectedObjectName;

  // Simulated objects in the scene
  final List<_SceneObject> _objects = [
    _SceneObject(name: 'Person', icon: Icons.person, rect: const Rect.fromLTWH(0.25, 0.15, 0.25, 0.6)),
    _SceneObject(name: 'Car', icon: Icons.directions_car, rect: const Rect.fromLTWH(0.55, 0.45, 0.35, 0.35)),
    _SceneObject(name: 'Background', icon: Icons.landscape, rect: const Rect.fromLTWH(0, 0, 1, 1)),
  ];

  late AnimationController _processingController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _processingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onVideoTap(TapDownDetails details) {
    if (_isProcessing) return;
    setState(() {
      _showAiMenu = true;
      _aiMenuPosition = details.localPosition;
      _selectedObjectName = 'Object';
    });
  }

  Future<void> _onActionSelected(String action) async {
    setState(() {
      _showAiMenu = false;
      _selectedAction = action;
      _isProcessing = true;
    });

    await Future.delayed(const Duration(milliseconds: 2500));

    if (mounted) {
      setState(() {
        _isProcessing = false;
        _selectedAction = null;
      });
      _showSuccessSnackbar();
    }
  }

  void _showSuccessSnackbar() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 18),
            const SizedBox(width: 10),
            Text(l10n.editApplied, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: AppColors.card,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: locale.textDirection,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                _buildAppBar(context, l10n, isDark),
                Expanded(child: _buildVideoArea(context, l10n, size, isDark)),
                _buildTimeline(isDark),
                _buildBottomNav(context, l10n, isDark),
              ],
            ),
            // AI Processing Overlay
            if (_isProcessing) _buildProcessingOverlay(l10n),
            // AI Action Menu
            if (_showAiMenu)
              AiActionMenu(
                position: _aiMenuPosition + const Offset(0, 80),
                onDismiss: () => setState(() => _showAiMenu = false),
                onActionSelected: _onActionSelected,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppLocalizations l10n, bool isDark) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      color: Colors.black,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Beach Sunset Reel',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  l10n.tapObject,
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              l10n.export,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoArea(BuildContext context, AppLocalizations l10n, Size size, bool isDark) {
    return GestureDetector(
      onTapDown: _onVideoTap,
      child: Stack(
        children: [
          // Video placeholder with cinematic gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D0D1A), Color(0xFF1A0D2E), Color(0xFF0D1A1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Scene visual elements
          _buildSceneVisuals(size),
          // Hint overlay (when no object selected)
          if (!_showAiMenu && !_isProcessing)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  borderRadius: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ScaleTransition(
                        scale: _pulseAnim,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.tapObject,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSceneVisuals(Size size) {
    return Stack(
      children: [
        // Sky gradient
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: size.height * 0.4,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A0D2E), Color(0xFF2D1B4E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Stars
        ...List.generate(20, (i) => Positioned(
          left: (i * 47.3 % 300) + 20,
          top: (i * 31.7 % 150) + 10,
          child: Container(
            width: i % 3 == 0 ? 3 : 2,
            height: i % 3 == 0 ? 3 : 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4 + (i % 3) * 0.2),
              shape: BoxShape.circle,
            ),
          ),
        )),
        // Ground
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: size.height * 0.35,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1A0D), Color(0xFF0A0A0F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Person silhouette
        Positioned(
          left: size.width * 0.25,
          top: size.height * 0.15,
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D1A6E).withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 35,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D1A6E).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        // Car silhouette
        Positioned(
          right: size.width * 0.05,
          bottom: size.height * 0.25,
          child: Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF1A0D3D).withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 10,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D1B69).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Moon / light source
        Positioned(
          right: size.width * 0.15,
          top: size.height * 0.08,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD4AF37).withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD4AF37).withOpacity(0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(bool isDark) {
    return Container(
      height: 64,
      color: Colors.black,
      child: Column(
        children: [
          // Scrubber
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: Colors.white.withOpacity(0.1),
              thumbColor: Colors.white,
              overlayColor: AppColors.primary.withOpacity(0.2),
            ),
            child: Slider(
              value: _progress,
              onChanged: (v) => setState(() => _progress = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isPlaying = !_isPlaying),
                  child: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Text(
                  '0:${(_progress * 32).toInt().toString().padLeft(2, '0')} / 0:32',
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                ),
                const Icon(Icons.more_horiz, color: Colors.white54, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, AppLocalizations l10n, bool isDark) {
    final tabs = [
      (icon: Icons.layers_outlined, label: l10n.objects),
      (icon: Icons.text_fields_rounded, label: l10n.text),
      (icon: Icons.music_note_outlined, label: l10n.audio),
      (icon: Icons.auto_awesome_outlined, label: l10n.style),
      (icon: Icons.file_upload_outlined, label: l10n.export),
    ];

    return Container(
      color: const Color(0xFF0D0D0D),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs.asMap().entries.map((entry) {
          final isActive = _currentTab == entry.key;
          return GestureDetector(
            onTap: () {
              setState(() => _currentTab = entry.key);
              if (entry.key == 4) _showExportSheet(context, l10n);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    entry.value.icon,
                    color: isActive ? AppColors.primary : Colors.white38,
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    entry.value.label,
                    style: TextStyle(
                      color: isActive ? AppColors.primary : Colors.white38,
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProcessingOverlay(AppLocalizations l10n) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: GlassCard(
            padding: const EdgeInsets.all(28),
            borderRadius: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: AnimatedBuilder(
                    animation: _processingController,
                    builder: (_, child) => Transform.rotate(
                      angle: _processingController.value * 6.28,
                      child: child,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [AppColors.primary.withOpacity(0), AppColors.primary],
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.card,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'AI Processing',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.aiProcessing,
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExportSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ExportSheet(l10n: l10n),
    );
  }
}

class _ExportSheet extends StatefulWidget {
  final AppLocalizations l10n;

  const _ExportSheet({required this.l10n});

  @override
  State<_ExportSheet> createState() => _ExportSheetState();
}

class _ExportSheetState extends State<_ExportSheet> {
  int _selectedPlatform = 0;
  int _selectedQuality = 0;
  bool _isExporting = false;

  final platforms = ['TikTok', 'Instagram Reels', 'YouTube Shorts', '1080p'];
  final platformIcons = [Icons.music_note, Icons.camera_alt, Icons.play_circle, Icons.hd];

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.exportVideo,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(l10n.exportPlatform, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: platforms.asMap().entries.map((e) => GestureDetector(
                onTap: () => setState(() => _selectedPlatform = e.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: _selectedPlatform == e.key ? AppColors.primary.withOpacity(0.15) : AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _selectedPlatform == e.key ? AppColors.primary : Colors.white.withOpacity(0.06),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(platformIcons[e.key], size: 14, color: _selectedPlatform == e.key ? AppColors.primary : AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text(
                        e.value,
                        style: TextStyle(
                          color: _selectedPlatform == e.key ? AppColors.primary : AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            Text(l10n.exportQuality, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedQuality = 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedQuality == 0 ? AppColors.primary.withOpacity(0.15) : AppColors.card,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _selectedQuality == 0 ? AppColors.primary : Colors.white.withOpacity(0.06)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.hd, color: _selectedQuality == 0 ? AppColors.primary : AppColors.textSecondary),
                          const SizedBox(height: 4),
                          Text('1080p', style: TextStyle(color: _selectedQuality == 0 ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.w600)),
                          Text('Full HD', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedQuality = 1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedQuality == 1 ? AppColors.accent.withOpacity(0.15) : AppColors.card,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _selectedQuality == 1 ? AppColors.accent : Colors.white.withOpacity(0.06)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.hd_outlined, color: _selectedQuality == 1 ? AppColors.accent : AppColors.textSecondary),
                          const SizedBox(height: 4),
                          Text('4K', style: TextStyle(color: _selectedQuality == 1 ? AppColors.accent : AppColors.textSecondary, fontWeight: FontWeight.w600)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ultra HD', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                              const SizedBox(width: 4),
                              const Icon(Icons.star, size: 10, color: AppColors.accent),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _isExporting ? null : () async {
                setState(() => _isExporting = true);
                await Future.delayed(const Duration(seconds: 2));
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                          const SizedBox(width: 10),
                          Text(l10n.editApplied),
                        ],
                      ),
                      backgroundColor: AppColors.card,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: _isExporting
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(
                          l10n.startExport,
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

class _SceneObject {
  final String name;
  final IconData icon;
  final Rect rect;

  const _SceneObject({required this.name, required this.icon, required this.rect});
}
