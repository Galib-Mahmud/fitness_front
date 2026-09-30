import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/trainer.dart';
import '../../widgets/common_widgets.dart';
import 'chat_detail_screen.dart';

class TrainerDetailScreen extends StatefulWidget {
  final Trainer trainer;

  const TrainerDetailScreen({
    super.key,
    required this.trainer,
  });

  @override
  State<TrainerDetailScreen> createState() => _TrainerDetailScreenState();
}

class _TrainerDetailScreenState extends State<TrainerDetailScreen> {
  bool _isSaved = false;

  void _showBookingModal(BuildContext context) {
    String selectedTime = '6:00 PM';
    String selectedDate = 'Today, Oct 12';

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Book a Session with ${widget.trainer.name}',
                    style: AppTypography.titleBold(
                      fontSize: 19,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Select your preferred date & time slot',
                    style: AppTypography.bodyRegular(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date selector
                  Text(
                    'Available Dates',
                    style: AppTypography.titleSemibold(fontSize: 14, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildDateChip('Today, Oct 12', selectedDate, (d) => setModalState(() => selectedDate = d)),
                      const SizedBox(width: 10),
                      _buildDateChip('Tomorrow, Oct 13', selectedDate, (d) => setModalState(() => selectedDate = d)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Time slots
                  Text(
                    'Available Time Slots',
                    style: AppTypography.titleSemibold(fontSize: 14, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: ['8:00 AM', '10:00 AM', '2:00 PM', '6:00 PM', '7:30 PM'].map((t) {
                      final isSelected = selectedTime == t;
                      return GestureDetector(
                        onTap: () => setModalState(() => selectedTime = t),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.border,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            t,
                            style: AppTypography.titleSemibold(
                              fontSize: 13,
                              color: isSelected ? AppColors.textDark : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // Summary & Confirm CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Cost', style: AppTypography.caption(color: AppColors.textMuted)),
                          Text(
                            '\$${widget.trainer.hourlyRate}.00',
                            style: AppTypography.displayBold(fontSize: 22, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: NeonButton(
                          text: 'Confirm Booking',
                          onPressed: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color(0xFF1E2420),
                                content: Text(
                                  '🎉 Session booked with ${widget.trainer.name} for $selectedDate at $selectedTime!',
                                  style: AppTypography.bodyMedium(color: AppColors.textPrimary),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDateChip(String date, String selectedDate, ValueChanged<String> onSelect) {
    final isSelected = date == selectedDate;
    return GestureDetector(
      onTap: () => onSelect(date),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Text(
          date,
          style: AppTypography.titleSemibold(
            fontSize: 12,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainer = widget.trainer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Banner (Figma #1:2191)
                Stack(
                  children: [
                    SizedBox(
                      height: 380,
                      width: double.infinity,
                      child: Image.asset(
                        trainer.bannerPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: AppColors.darkCardGradient,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.background.withValues(alpha: 0.4),
                              AppColors.background,
                            ],
                            stops: const [0.0, 0.6, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Top Bar controls
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).maybePop(),
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppColors.border, width: 1),
                                ),
                                child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textPrimary),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() => _isSaved = !_isSaved);
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppColors.border, width: 1),
                                    ),
                                    child: Icon(
                                      _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                      size: 20,
                                      color: _isSaved ? AppColors.primary : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ChatDetailScreen(
                                          trainerName: trainer.name,
                                          avatarPath: trainer.imagePath,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppColors.border, width: 1),
                                    ),
                                    child: const Icon(Icons.chat_bubble_outline_rounded, size: 20, color: AppColors.textPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Trainer Avatar & Name Overlay (Figma #1:2206)
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 12,
                      child: Row(
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: AppColors.primary, width: 2),
                              image: DecorationImage(
                                image: AssetImage(trainer.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trainer.name,
                                  style: AppTypography.displayBold(
                                    fontSize: 24,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  trainer.specialty,
                                  style: AppTypography.bodyRegular(
                                    fontSize: 14,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Stat Row (Figma #1:2211)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('★ ${trainer.rating}', 'Rating', AppColors.accentYellow),
                        Container(width: 1, height: 32, color: AppColors.border),
                        _buildStatItem('${trainer.reviewsCount}', 'Reviews', AppColors.textPrimary),
                        Container(width: 1, height: 32, color: AppColors.border),
                        _buildStatItem('${trainer.matchPercent}%', 'Match', AppColors.primary),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Great match banner (Figma #1:2226)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2822),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1),
                    ),
                    child: Row(
                      children: [
                        // Circular badge
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary, width: 3),
                            color: AppColors.background,
                          ),
                          child: Center(
                            child: Text(
                              '${trainer.matchPercent}%',
                              style: AppTypography.titleBold(
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Great match for your goals',
                                style: AppTypography.titleBold(
                                  fontSize: 15,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Based on your questionnaire — strength focus, 3–4×/week, gym setting.',
                                style: AppTypography.bodyRegular(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // About section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Coach',
                        style: AppTypography.titleBold(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        trainer.bio,
                        style: AppTypography.bodyRegular(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Skills & Specialties (Figma #1:2238)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Skills & Specialties',
                        style: AppTypography.titleBold(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: trainer.skills.map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border, width: 1),
                            ),
                            child: Text(
                              skill,
                              style: AppTypography.titleSemibold(
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Certifications & Details (Figma #1:2249)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Credentials & Experience',
                        style: AppTypography.titleBold(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          children: [
                            _buildCredentialItem(
                              Icons.verified_rounded,
                              'Certifications',
                              trainer.certifications.join(', '),
                            ),
                            const Divider(color: AppColors.border, height: 24),
                            _buildCredentialItem(
                              Icons.history_rounded,
                              'Experience',
                              trainer.experienceYears,
                            ),
                            const Divider(color: AppColors.border, height: 24),
                            _buildCredentialItem(
                              Icons.translate_rounded,
                              'Languages',
                              trainer.languages.join(', '),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Fixed Booking Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: const Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Per Session',
                          style: AppTypography.caption(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            text: '\$${trainer.hourlyRate}',
                            style: AppTypography.displayBold(
                              fontSize: 24,
                              color: AppColors.primary,
                            ),
                            children: [
                              TextSpan(
                                text: ' /hr',
                                style: AppTypography.caption(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: NeonButton(
                        text: 'Book Session',
                        onPressed: () => _showBookingModal(context),
                      ),
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

  Widget _buildStatItem(String val, String label, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: AppTypography.titleBold(
            fontSize: 17,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.caption(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.caption(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: AppTypography.titleSemibold(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
