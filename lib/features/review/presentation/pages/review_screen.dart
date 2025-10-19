import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class ReviewScreen extends StatefulWidget {
  final String? targetId; // doctor_id or 'app' for app review
  final ReviewType? reviewType;
  final String? targetName; // doctor's name or 'التطبيق' for app

  const ReviewScreen({
    super.key,
    this.targetId,
    this.reviewType,
    this.targetName,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 0.0;
  final TextEditingController _commentController = TextEditingController();
  final List<String> _selectedTags = [];
  bool _isAnonymous = false;
  bool _isSubmitting = false;

  final List<String> _positiveTags = [
    'محترف',
    'ودود',
    'دقيق في التشخيص',
    'يشرح جيداً',
    'منظم',
    'متعاون',
  ];

  final List<String> _negativeTags = [
    'تأخر في الموعد',
    'غير واضح في الشرح',
    'غير مهذب',
    'تكلفة عالية',
    'انتظار طويل',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetName = widget.targetName ?? 'الطبيب';
    final reviewType = widget.reviewType ?? ReviewType.doctor;

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'تقييم ${reviewType == ReviewType.app ? 'التطبيق' : targetName}',
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header
            _buildHeader(reviewType, targetName),

            const SizedBox(height: 32),

            // Star Rating
            _buildStarRating(),

            const SizedBox(height: 32),

            // Comment Section
            _buildCommentSection(),

            const SizedBox(height: 32),

            // Tags Section
            if (reviewType != ReviewType.app) _buildTagsSection(),

            const SizedBox(height: 32),

            // Anonymous Option
            _buildAnonymousOption(),

            const SizedBox(height: 32),

            // Submit Button
            PrimaryButton(
              text: 'إرسال التقييم',
              onPressed: _rating > 0 ? _submitReview : null,
              isLoading: _isSubmitting,
            ),

            const SizedBox(height: 16),

            SecondaryButton(
              text: 'تجاهل',
              onPressed: () => context.pop(),
            ),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
    );
  }

  Widget _buildHeader(ReviewType reviewType, String targetName) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar/Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: reviewType == ReviewType.app
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: reviewType == ReviewType.app
                ? const Icon(
                    Icons.star,
                    color: AppColors.primary,
                    size: 30,
                  )
                : const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  reviewType == ReviewType.app
                      ? 'تقييم التطبيق'
                      : 'تقييم الطبيب',
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  reviewType == ReviewType.app
                      ? 'شاركنا رأيك في التطبيق لمساعدتنا على تحسينه'
                      : 'كيف كانت تجربتك مع $targetName؟',
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: AppColors.homeSecondaryText,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'التقييم',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  size: 40,
                  color: index < _rating ? Colors.amber : Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          _getRatingText(),
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            color: AppColors.homeSecondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'التعليق (اختياري)',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _commentController,
            maxLines: 4,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'شاركنا المزيد من التفاصيل...',
              hintStyle: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
            ),
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_commentController.text.length}/500',
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 12,
            color: AppColors.homeSecondaryText,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'ما الذي لاحظته؟',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 16),

        // Positive Tags
        Text(
          'الجوانب الإيجابية',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green.shade700,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children:
              _positiveTags.map((tag) => _buildTagChip(tag, true)).toList(),
        ),

        const SizedBox(height: 16),

        // Negative Tags
        Text(
          'الجوانب التي تحتاج تحسين',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red.shade700,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children:
              _negativeTags.map((tag) => _buildTagChip(tag, false)).toList(),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag, bool isPositive) {
    final isSelected = _selectedTags.contains(tag);

    return FilterChip(
      label: Text(
        tag,
        style: TextStyle(
          fontFamily: 'IBM Plex Sans Arabic',
          fontSize: 14,
          color: isSelected ? Colors.white : AppColors.primary,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedTags.add(tag);
          } else {
            _selectedTags.remove(tag);
          }
        });
      },
      backgroundColor: Colors.white,
      selectedColor: isPositive ? Colors.green : Colors.red,
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? (isPositive ? Colors.green : Colors.red)
              : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildAnonymousOption() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isAnonymous,
            onChanged: (value) => setState(() => _isAnonymous = value ?? false),
            activeColor: AppColors.primary,
          ),
          const Expanded(
            child: Text(
              'نشر التقييم بشكل مجهول',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const Icon(
            Icons.visibility_off,
            color: AppColors.homeSecondaryText,
            size: 20,
          ),
        ],
      ),
    );
  }

  String _getRatingText() {
    if (_rating == 0) return 'اضغط على النجوم للتقييم';
    if (_rating <= 1) return 'سيء جداً';
    if (_rating <= 2) return 'سيء';
    if (_rating <= 3) return 'جيد';
    if (_rating <= 4) return 'جيد جداً';
    return 'ممتاز';
  }

  void _submitReview() async {
    if (_rating == 0) return;

    setState(() => _isSubmitting = true);

    // TODO: Implement review submission
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isSubmitting = false);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'تم إرسال التقييم',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          content: const Text(
            'شكراً لك على تقييمك. رأيك مهم بالنسبة لنا.',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
            ),
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              child: const Text(
                'موافق',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
