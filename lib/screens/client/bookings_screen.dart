import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/booking.dart';
import '../../widgets/common_widgets.dart';
import 'chat_detail_screen.dart';
import 'trainer_detail_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedTab = 0; // 0 = Upcoming, 1 = completed

  @override
  Widget build(BuildContext context) {
    final allBookings = Booking.sampleBookings;
    final upcomingBookings = allBookings.where((b) => b.status == BookingStatus.confirmed).toList();
    final completedBookings = allBookings.where((b) => b.status == BookingStatus.completed).toList();
    final currentList = _selectedTab == 0 ? upcomingBookings : completedBookings;

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

              // Screen Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Bookings',
                  style: AppTypography.displayBold(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tab Slider matching Figma (Upcoming / completed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomSliderTabs(
                  tabs: const ['Upcoming', 'completed'],
                  selectedIndex: _selectedTab,
                  onTabChanged: (idx) {
                    setState(() => _selectedTab = idx);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Bookings List
              if (currentList.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.event_busy_rounded,
                          size: 48,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No bookings found',
                          style: AppTypography.titleSemibold(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: currentList.length,
                  itemBuilder: (context, index) {
                    final booking = currentList[index];
                    return _buildBookingCard(context, booking);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Booking booking) {
    final isUpcoming = booking.status == BookingStatus.confirmed;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isUpcoming ? AppColors.primary.withValues(alpha: 0.3) : AppColors.border,
          width: 1,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isUpcoming
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isUpcoming ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  isUpcoming ? 'CONFIRMED' : 'COMPLETED',
                  style: AppTypography.caption(
                    fontSize: 11,
                    color: isUpcoming ? AppColors.primary : AppColors.textMuted,
                  ),
                ),
              ),
              Text(
                '\$${booking.cost.toInt()}',
                style: AppTypography.titleBold(
                  fontSize: 17,
                  color: isUpcoming ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Trainer Info
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(booking.trainer.imagePath),
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
                      booking.trainer.name,
                      style: AppTypography.titleBold(
                        fontSize: 17,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      booking.sessionType,
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

          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 14),

          // Date, Time & Location
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                booking.dateTimeText,
                style: AppTypography.titleSemibold(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  booking.location,
                  style: AppTypography.bodyRegular(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Action Buttons
          if (isUpcoming)
            Row(
              children: [
                Expanded(
                  child: SecondaryDarkButton(
                    text: 'Reschedule',
                    height: 42,
                    backgroundColor: AppColors.surfaceElevated,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reschedule request sent to trainer.')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SecondaryDarkButton(
                    text: 'Chat',
                    height: 42,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    textColor: AppColors.primary,
                    borderColor: AppColors.primary.withValues(alpha: 0.3),
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 15, color: AppColors.primary),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(
                            trainerName: booking.trainer.name,
                            avatarPath: booking.trainer.imagePath,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: NeonButton(
                    text: 'Leave a review',
                    height: 42,
                    onPressed: () {
                      _showReviewDialog(context, booking.trainer);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SecondaryDarkButton(
                    text: 'Rebook',
                    height: 42,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TrainerDetailScreen(trainer: booking.trainer),
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
  }

  void _showReviewDialog(BuildContext context, dynamic trainer) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'Review ${trainer.name}',
          style: AppTypography.titleBold(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return const Icon(Icons.star_rounded, size: 32, color: AppColors.accentYellow);
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              style: AppTypography.bodyMedium(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Share your experience with this coach...',
                hintStyle: AppTypography.bodyRegular(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceElevated,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you! Your review has been submitted.')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
