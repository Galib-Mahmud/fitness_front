import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class TrainerScheduleScreen extends StatefulWidget {
  const TrainerScheduleScreen({super.key});

  @override
  State<TrainerScheduleScreen> createState() => _TrainerScheduleScreenState();
}

class _TrainerScheduleScreenState extends State<TrainerScheduleScreen> {
  int _selectedView = 0; // 0 = Weekly, 1 = Calendar
  int _selectedDayIndex = 0;

  final List<Map<String, String>> _days = [
    {'day': 'Sun', 'date': '12'},
    {'day': 'Mon', 'date': '13'},
    {'day': 'Tue', 'date': '14'},
    {'day': 'Wed', 'date': '15'},
    {'day': 'Thu', 'date': '16'},
    {'day': 'Fri', 'date': '17'},
    {'day': 'Sat', 'date': '18'},
  ];

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

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule',
                      style: AppTypography.displayBold(
                        fontSize: 28,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary, size: 26),
                      onPressed: () => _showAddSlotModal(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // View toggle matching Figma: Weekly vs Calendar (Figma #1:5590)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomSliderTabs(
                  tabs: const ['Weekly', 'Calendar'],
                  selectedIndex: _selectedView,
                  onTabChanged: (idx) => setState(() => _selectedView = idx),
                ),
              ),

              const SizedBox(height: 20),

              // Horizontal Day Picker matching Figma (Figma #1:5613)
              SizedBox(
                height: 78,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final item = _days[index];
                    final isSelected = _selectedDayIndex == index;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDayIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 58,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.primaryGradient : null,
                          color: isSelected ? null : AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: 1,
                          ),
                          boxShadow: isSelected ? AppColors.primaryGlow : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['day']!,
                              style: AppTypography.titleSemibold(
                                fontSize: 13,
                                color: isSelected ? AppColors.textDark : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['date']!,
                              style: AppTypography.displayBold(
                                fontSize: 18,
                                color: isSelected ? AppColors.textDark : AppColors.textPrimary,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: AppColors.textDark,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sessions for ${_days[_selectedDayIndex]['day']} ${_days[_selectedDayIndex]['date']} Oct',
                      style: AppTypography.titleBold(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '4 booked · 2 open',
                      style: AppTypography.caption(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Time slots list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildSlotItem(
                      time: '8:00 AM - 9:00 AM',
                      isOpen: true,
                    ),
                    _buildSlotItem(
                      time: '10:00 AM - 11:00 AM',
                      clientName: 'Sarah Jenkins',
                      sessionType: 'Strength & Hypertrophy',
                      location: 'MetroFlex Fitness',
                      avatarPath: 'assets/images/client_profile_avatar.png',
                    ),
                    _buildSlotItem(
                      time: '2:00 PM - 3:00 PM',
                      clientName: 'Michael Chang',
                      sessionType: 'Powerlifting Fundamentals',
                      location: 'MetroFlex Fitness',
                      avatarPath: 'assets/images/alex_johnson.png',
                    ),
                    _buildSlotItem(
                      time: '4:30 PM - 5:30 PM',
                      isOpen: true,
                    ),
                    _buildSlotItem(
                      time: '6:00 PM - 7:00 PM',
                      clientName: 'Elena Rostova',
                      sessionType: 'Marathon Mobility Prep',
                      location: 'Equinox Studio 4',
                      avatarPath: 'assets/images/maya_thompson.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlotItem({
    required String time,
    bool isOpen = false,
    String? clientName,
    String? sessionType,
    String? location,
    String? avatarPath,
  }) {
    if (isOpen) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border, width: 1, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.radio_button_unchecked_rounded, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: AppTypography.titleSemibold(fontSize: 13, color: AppColors.textMuted),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'OPEN SLOT',
                style: AppTypography.caption(fontSize: 10, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(avatarPath!),
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
                      clientName!,
                      style: AppTypography.titleBold(fontSize: 15, color: AppColors.textPrimary),
                    ),
                    Text(
                      time,
                      style: AppTypography.caption(fontSize: 11, color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  sessionType!,
                  style: AppTypography.bodyRegular(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      location!,
                      style: AppTypography.caption(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddSlotModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Available Time Slot', style: AppTypography.titleBold(fontSize: 18, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            const Text('Choose a time range to open for client bookings:'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: ['7:00 AM', '11:30 AM', '3:00 PM', '8:00 PM'].map((t) {
                return Chip(
                  backgroundColor: AppColors.surfaceElevated,
                  label: Text(t, style: const TextStyle(color: AppColors.textPrimary)),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            NeonButton(
              text: 'Save Slot',
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }
}
