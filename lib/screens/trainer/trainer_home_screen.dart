import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../client/chat_detail_screen.dart';

class TrainerHomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToRequests;
  final VoidCallback? onNavigateToSchedule;

  const TrainerHomeScreen({
    super.key,
    this.onNavigateToRequests,
    this.onNavigateToSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FigmaStatusBar(),
              const SizedBox(height: 8),

              // Header Bar: Greeting + Notification Bell + Avatar (Figma #1:3563)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/trainer_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Greeting
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back 💪',
                            style: AppTypography.caption(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Coach Alex',
                            style: AppTypography.titleBold(
                              fontSize: 19,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Notification bell
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            size: 22,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Positioned(
                          top: -3,
                          right: -3,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '4',
                              style: AppTypography.displayBold(
                                fontSize: 10,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // "This Month" Earnings Card (Figma #1:3574)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppColors.primaryGlow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'This Month Earnings',
                            style: AppTypography.titleSemibold(
                              fontSize: 14,
                              color: const Color(0xFF14301B),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.trending_up_rounded, size: 14, color: AppColors.textDark),
                                const SizedBox(width: 4),
                                Text(
                                  '+18% vs last month',
                                  style: AppTypography.titleBold(
                                    fontSize: 11,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '\$3,240',
                        style: AppTypography.displayBold(
                          fontSize: 38,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total 42 completed client sessions',
                        style: AppTypography.caption(
                          fontSize: 12,
                          color: const Color(0xFF1A3822),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Metrics Row (Figma #1:3588)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMetricTile('42', 'Sessions', Icons.fitness_center_rounded),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricTile('12', 'New Clients', Icons.person_add_alt_1_rounded),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMetricTile('4.9', 'Avg Rating', Icons.star_rounded, isRating: true),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Today's Schedule Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Schedule (3)",
                      style: AppTypography.titleBold(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: onNavigateToSchedule,
                      child: Text(
                        'View calendar',
                        style: AppTypography.titleSemibold(
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Today's Client Sessions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildSessionItem(
                      context,
                      clientName: 'Sarah Jenkins',
                      time: '10:00 AM - 11:00 AM',
                      goal: 'Strength & Hypertrophy',
                      status: 'COMPLETED',
                      avatarPath: 'assets/images/client_profile_avatar.png',
                      isCompleted: true,
                    ),
                    _buildSessionItem(
                      context,
                      clientName: 'Michael Chang',
                      time: '2:00 PM - 3:00 PM',
                      goal: 'Powerlifting Form Check',
                      status: 'NEXT UP',
                      avatarPath: 'assets/images/alex_johnson.png',
                      isNext: true,
                    ),
                    _buildSessionItem(
                      context,
                      clientName: 'Elena Rostova',
                      time: '6:00 PM - 7:00 PM',
                      goal: 'Marathon Mobility Prep',
                      status: 'CONFIRMED',
                      avatarPath: 'assets/images/maya_thompson.png',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricTile(String value, String label, IconData icon, {bool isRating = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: isRating ? AppColors.accentYellow : AppColors.primary),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTypography.displayBold(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(
    BuildContext context, {
    required String clientName,
    required String time,
    required String goal,
    required String status,
    required String avatarPath,
    bool isCompleted = false,
    bool isNext = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isNext ? AppColors.primary.withValues(alpha: 0.5) : AppColors.border,
          width: isNext ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(avatarPath),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      clientName,
                      style: AppTypography.titleBold(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isNext
                            ? AppColors.primary
                            : isCompleted
                                ? AppColors.surfaceLight
                                : AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: AppTypography.displayBold(
                          fontSize: 9,
                          color: isNext ? AppColors.textDark : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  goal,
                  style: AppTypography.bodyRegular(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.schedule_rounded, size: 13, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: AppTypography.caption(
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18, color: AppColors.textMuted),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatDetailScreen(
                    trainerName: clientName,
                    avatarPath: avatarPath,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
