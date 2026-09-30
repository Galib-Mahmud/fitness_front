import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

enum AppRole { client, trainer }

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final AppRole role;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.role = AppRole.client,
  });

  @override
  Widget build(BuildContext context) {
    final clientItems = [
      _NavItem(
        iconPath: 'assets/icons/home.svg',
        fallbackIcon: Icons.home_rounded,
        label: 'Home',
      ),
      _NavItem(
        iconPath: 'assets/icons/search.svg',
        fallbackIcon: Icons.search_rounded,
        label: 'Discover',
      ),
      _NavItem(
        iconPath: 'assets/icons/calendar.svg',
        fallbackIcon: Icons.calendar_month_rounded,
        label: 'Bookings',
      ),
      _NavItem(
        iconPath: 'assets/icons/chat.svg',
        fallbackIcon: Icons.chat_bubble_outline_rounded,
        label: 'Chat',
      ),
      _NavItem(
        iconPath: 'assets/icons/user.svg',
        fallbackIcon: Icons.person_outline_rounded,
        label: 'Profile',
      ),
    ];

    final trainerItems = [
      _NavItem(
        iconPath: 'assets/icons/home.svg',
        fallbackIcon: Icons.home_rounded,
        label: 'Home',
      ),
      _NavItem(
        iconPath: 'assets/icons/search.svg',
        fallbackIcon: Icons.people_alt_outlined,
        label: 'Requests',
      ),
      _NavItem(
        iconPath: 'assets/icons/calendar.svg',
        fallbackIcon: Icons.calendar_today_rounded,
        label: 'Schedule',
      ),
      _NavItem(
        iconPath: 'assets/icons/chat.svg',
        fallbackIcon: Icons.chat_bubble_outline_rounded,
        label: 'Chat',
      ),
      _NavItem(
        iconPath: 'assets/icons/user.svg',
        fallbackIcon: Icons.person_outline_rounded,
        label: 'Profile',
      ),
    ];

    final items = role == AppRole.client ? clientItems : trainerItems;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF121417).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = currentIndex == index;
          final item = items[index];

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF202622) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? Border.all(color: AppColors.primary.withValues(alpha: 0.35), width: 1)
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        item.iconPath,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          isSelected ? AppColors.primary : AppColors.textMuted,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.label,
                      style: AppTypography.caption(
                        fontSize: 10,
                        color: isSelected ? AppColors.primary : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String iconPath;
  final IconData fallbackIcon;
  final String label;

  const _NavItem({
    required this.iconPath,
    required this.fallbackIcon,
    required this.label,
  });
}
