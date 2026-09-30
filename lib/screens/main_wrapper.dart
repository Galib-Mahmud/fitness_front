import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav.dart';
import 'client/client_home_screen.dart';
import 'client/discover_screen.dart';
import 'client/bookings_screen.dart';
import 'client/chat_list_screen.dart';
import 'client/client_profile_screen.dart';
import 'trainer/trainer_home_screen.dart';
import 'trainer/trainer_requests_screen.dart';
import 'trainer/trainer_schedule_screen.dart';
import 'trainer/trainer_profile_screen.dart';

class MainWrapper extends StatefulWidget {
  final AppRole initialRole;
  final int initialIndex;

  const MainWrapper({
    super.key,
    this.initialRole = AppRole.client,
    this.initialIndex = 0,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late AppRole _currentRole;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentRole = widget.initialRole;
    _currentIndex = widget.initialIndex;
  }

  void _switchRole() {
    setState(() {
      _currentRole = _currentRole == AppRole.client ? AppRole.trainer : AppRole.client;
      _currentIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E2822),
        duration: const Duration(milliseconds: 1500),
        content: Text(
          _currentRole == AppRole.client
              ? 'Switched to Client Mode (Find & Book Coaches)'
              : 'Switched to Trainer Mode (Manage Clients & Schedule)',
          style: AppTypography.bodyMedium(color: AppColors.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Client screens
    final clientScreens = [
      ClientHomeScreen(
        onNavigateToDiscover: () => setState(() => _currentIndex = 1),
        onNavigateToChat: () => setState(() => _currentIndex = 3),
      ),
      const DiscoverScreen(),
      const BookingsScreen(),
      const ChatListScreen(),
      ClientProfileScreen(
        onSwitchRole: _switchRole,
      ),
    ];

    // Trainer screens
    final trainerScreens = [
      TrainerHomeScreen(
        onNavigateToRequests: () => setState(() => _currentIndex = 1),
        onNavigateToSchedule: () => setState(() => _currentIndex = 2),
      ),
      const TrainerRequestsScreen(),
      const TrainerScheduleScreen(),
      const ChatListScreen(),
      TrainerProfileScreen(
        onSwitchRole: _switchRole,
      ),
    ];

    final activeScreens = _currentRole == AppRole.client ? clientScreens : trainerScreens;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Active Screen
          IndexedStack(
            index: _currentIndex,
            children: activeScreens,
          ),

          // Floating Role Toggle Pill at top-right for quick Pair Programming & Inspection
          Positioned(
            top: 48,
            right: 20,
            child: GestureDetector(
              onTap: _switchRole,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  boxShadow: AppColors.primaryGlow,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _currentRole == AppRole.client ? 'Client' : 'Trainer',
                      style: AppTypography.displayBold(
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Custom Bottom Navigation Bar matching Figma
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNav(
              currentIndex: _currentIndex,
              role: _currentRole,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
