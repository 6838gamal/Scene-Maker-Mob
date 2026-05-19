import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../theme/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _feedbackType = 0;
  double _rating = 4.0;
  final _feedbackController = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LocaleProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final bgColor = isDark ? AppColors.background : AppColors.lightBackground;
    final cardColor = isDark ? AppColors.card : AppColors.lightCard;

    if (_submitted) return _buildSuccessScreen(context, l10n, isDark, bgColor, textColor);

    final feedbackTypes = [l10n.bugReport, l10n.featureRequest, l10n.generalFeedback];

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
          title: Text(l10n.feedbackTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.feedbackDesc,
                        style: const TextStyle(color: AppColors.primary, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Feedback type
              Text(l10n.feedbackType, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                children: feedbackTypes.asMap().entries.map((entry) {
                  final isSelected = _feedbackType == entry.key;
                  return GestureDetector(
                    onTap: () => setState(() => _feedbackType = entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withOpacity(0.15) : cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : (isDark ? Colors.white.withOpacity(0.08) : Colors.grey.withOpacity(0.2)),
                        ),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: isSelected ? AppColors.primary : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              // Rating
              Text(l10n.rateApp, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 12),
              Center(
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(Icons.star_rounded, color: AppColors.accent),
                  onRatingUpdate: (r) => setState(() => _rating = r),
                ),
              ),

              const SizedBox(height: 24),
              // Feedback text
              Text(l10n.yourFeedback, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 12),
              TextField(
                controller: _feedbackController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: l10n.feedbackHint,
                  filled: true,
                  fillColor: cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey.withOpacity(0.15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  hintStyle: const TextStyle(color: AppColors.textMuted),
                ),
                style: TextStyle(color: textColor),
              ),

              const SizedBox(height: 32),
              GestureDetector(
                onTap: _isSubmitting ? null : _submit,
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
                    child: _isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Text(l10n.submitFeedback, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _isSubmitting = false;
      _submitted = true;
    });
  }

  Widget _buildSuccessScreen(BuildContext context, AppLocalizations l10n, bool isDark, Color bgColor, Color textColor) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.success, Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.thankYou,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.feedbackReceived,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(l10n.done, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
