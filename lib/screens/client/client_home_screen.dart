import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/trainer.dart';
import '../../widgets/common_widgets.dart';
import 'trainer_detail_screen.dart';
import 'chat_detail_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  final VoidCallback? onNavigateToDiscover;
  final VoidCallback? onNavigateToChat;

  const ClientHomeScreen({
    super.key,
    this.onNavigateToDiscover,
    this.onNavigateToChat,
  });

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Strength',
    'HIIT',
    'Yoga',
    'CrossFit',
    'Mobility',
  ];

  @override
  Widget build(BuildContext context) {
    final trainers = Trainer.sampleTrainers;

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

              // Header Bar: Greeting + Notification Bell + Avatar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/client_profile_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Greeting & Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Good morning 👋',
                                style: AppTypography.caption(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Alex Johnson',
                            style: AppTypography.titleBold(
                              fontSize: 19,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Notification Icon with Badge "3" (Figma #1:3171)
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
                              '3',
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

              // Search Bar matching Figma
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FigmaSearchBar(
                  onFilterTap: widget.onNavigateToDiscover,
                  onChanged: (val) {},
                ),
              ),

              const SizedBox(height: 22),

              // Featured Upcoming Session Banner (Figma #1:3183)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildUpcomingSessionCard(context),
              ),

              const SizedBox(height: 28),

              // Specialty Category Filter Pills
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cat,
                          style: AppTypography.titleSemibold(
                            fontSize: 13,
                            color: isSelected ? AppColors.textDark : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Recommended For You Header (Figma #1:3198)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended For You',
                      style: AppTypography.titleBold(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onNavigateToDiscover,
                      child: Text(
                        'See all',
                        style: AppTypography.titleSemibold(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Horizontal Trainer Cards List (Figma #1:3201)
              SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 4),
                  itemCount: trainers.length,
                  itemBuilder: (context, index) {
                    final trainer = trainers[index];
                    return TrainerCardWidget(
                      trainer: trainer,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TrainerDetailScreen(trainer: trainer),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Quick Stats & Streak Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildStreakBanner(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingSessionCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF263328), Color(0xFF141A16)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'UPCOMING SESSION',
                  style: AppTypography.displayBold(
                    fontSize: 10,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 14, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    'In 2 hours',
                    style: AppTypography.caption(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Trainer Info
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/trainer_avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Rivera',
                      style: AppTypography.titleBold(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Today · 6:00 PM (Strength)',
                      style: AppTypography.bodyRegular(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Actions Row (Figma #1:3190)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SecondaryDarkButton(
                  text: 'View details',
                  height: 44,
                  backgroundColor: AppColors.surface,
                  borderColor: AppColors.border,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TrainerDetailScreen(
                          trainer: Trainer.sampleTrainers[0],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SecondaryDarkButton(
                  text: 'Chat',
                  height: 44,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary.withValues(alpha: 0.4),
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppColors.primary),
                  onPressed: () {
                    if (widget.onNavigateToChat != null) {
                      widget.onNavigateToChat!();
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(
                            trainerName: 'Alex Rivera',
                            avatarPath: 'assets/images/trainer_avatar.png',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBanner() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accentOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.accentOrange,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5 Days Workout Streak! 🔥',
                  style: AppTypography.titleBold(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You completed 4 sessions this week. Keep crushing it!',
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
    );
  }
}
