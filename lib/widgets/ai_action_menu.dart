import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

class AiAction {
  final String key;
  final IconData icon;
  final List<Color> colors;

  const AiAction({
    required this.key,
    required this.icon,
    required this.colors,
  });
}

final kAiActions = [
  const AiAction(
    key: 'remove',
    icon: Icons.remove_circle_outline,
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
  ),
  const AiAction(
    key: 'replace',
    icon: Icons.swap_horiz,
    colors: [Color(0xFF7C3AED), Color(0xFF9D61FF)],
  ),
  const AiAction(
    key: 'recolor',
    icon: Icons.palette_outlined,
    colors: [Color(0xFF06B6D4), Color(0xFF0EA5E9)],
  ),
  const AiAction(
    key: 'animate',
    icon: Icons.animation,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  ),
  const AiAction(
    key: 'relight',
    icon: Icons.wb_sunny_outlined,
    colors: [Color(0xFFD4AF37), Color(0xFFF59E0B)],
  ),
];

class AiActionMenu extends StatefulWidget {
  final Offset position;
  final VoidCallback onDismiss;
  final Function(String action) onActionSelected;

  const AiActionMenu({
    super.key,
    required this.position,
    required this.onDismiss,
    required this.onActionSelected,
  });

  @override
  State<AiActionMenu> createState() => _AiActionMenuState();
}

class _AiActionMenuState extends State<AiActionMenu>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    String actionLabel(String key) {
      switch (key) {
        case 'remove': return l10n.remove;
        case 'replace': return l10n.replace;
        case 'recolor': return l10n.recolor;
        case 'animate': return l10n.animate;
        case 'relight': return l10n.relight;
        default: return key;
      }
    }

    double menuWidth = 280;
    double menuHeight = 80;
    double left = widget.position.dx - menuWidth / 2;
    double top = widget.position.dy - menuHeight - 20;

    left = left.clamp(12.0, size.width - menuWidth - 12);
    top = top.clamp(80.0, size.height - menuHeight - 80);

    return Stack(
      children: [
        // Dismiss layer
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Menu
        Positioned(
          left: left,
          top: top,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              alignment: Alignment.bottomCenter,
              child: _buildMenu(context, l10n, actionLabel),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenu(BuildContext context, AppLocalizations l10n, String Function(String) actionLabel) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.aiActions,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: kAiActions.map((action) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _ActionButton(
                  action: action,
                  label: actionLabel(action.key),
                  onTap: () => widget.onActionSelected(action.key),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final AiAction action;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.action,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: action.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: action.colors.first.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(action.icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
