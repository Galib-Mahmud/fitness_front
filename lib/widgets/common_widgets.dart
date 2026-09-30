import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../models/trainer.dart';

/// Neon primary gradient button from Figma
class NeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final Widget? icon;
  final bool isFullWidth;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 54,
    this.width,
    this.icon,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.primaryGlow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: AppTypography.displayMedium(
                    fontSize: 15,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Secondary Dark Button matching Figma (#262626 or stroke)
class SecondaryDarkButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double? width;
  final Widget? icon;
  final bool isFullWidth;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const SecondaryDarkButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 54,
    this.width,
    this.icon,
    this.isFullWidth = true,
    this.backgroundColor = AppColors.surfaceLight,
    this.textColor = AppColors.textPrimary,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: AppTypography.titleSemibold(
                    fontSize: 15,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Simulated Phone Status Bar matching Figma
class FigmaStatusBar extends StatelessWidget {
  final String time;
  final Color contentColor;

  const FigmaStatusBar({
    super.key,
    this.time = '9:41',
    this.contentColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: AppTypography.titleBold(fontSize: 14, color: contentColor),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt_rounded, size: 16, color: contentColor),
              const SizedBox(width: 4),
              Icon(Icons.wifi_rounded, size: 16, color: contentColor),
              const SizedBox(width: 6),
              Icon(Icons.battery_full_rounded, size: 18, color: contentColor),
            ],
          ),
        ],
      ),
    );
  }
}

/// Sleek Figma Search Bar with SVG Icons
class FigmaSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const FigmaSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search trainers, workouts, goals...',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(AppColors.textMuted, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.bodyMedium(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTypography.bodyRegular(color: AppColors.textMuted),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (onFilterTap != null)
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Pill tab slider matching Figma ("Upcoming" / "Completed", "Weekly" / "Calendar", etc.)
class CustomSliderTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const CustomSliderTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.primaryGradient : null,
                  color: isSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: AppTypography.titleSemibold(
                    fontSize: 14,
                    color: isSelected ? AppColors.textDark : AppColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Recommended Trainer Card from Figma (Alex Rivera, etc.)
class TrainerCardWidget extends StatelessWidget {
  final Trainer trainer;
  final VoidCallback onTap;
  final VoidCallback? onBookTap;

  const TrainerCardWidget({
    super.key,
    required this.trainer,
    required this.onTap,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 270,
        height: 290,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: AppColors.softShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                trainer.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.darkCardGradient,
                    ),
                    child: const Icon(Icons.fitness_center_rounded, size: 48, color: AppColors.primary),
                  );
                },
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.85),
                      AppColors.background,
                    ],
                    stops: const [0.0, 0.4, 0.75, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Match badge top left
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome_rounded, size: 12, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '${trainer.matchPercent}% Match',
                      style: AppTypography.displayMedium(fontSize: 11, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            ),
            // Distance badge top right
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Text(
                  '${trainer.distanceMi} mi',
                  style: AppTypography.caption(fontSize: 11, color: AppColors.textSecondary),
                ),
              ),
            ),
            // Bottom Info
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trainer.name,
                    style: AppTypography.titleBold(fontSize: 18, color: AppColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trainer.specialty,
                    style: AppTypography.bodyRegular(fontSize: 12, color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 15, color: AppColors.accentYellow),
                          const SizedBox(width: 4),
                          Text(
                            '${trainer.rating}',
                            style: AppTypography.titleBold(fontSize: 13, color: AppColors.textPrimary),
                          ),
                          Text(
                            ' (${trainer.reviewsCount})',
                            style: AppTypography.caption(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '\$${trainer.hourlyRate}',
                          style: AppTypography.displayBold(fontSize: 18, color: AppColors.primary),
                          children: [
                            TextSpan(
                              text: ' /hr',
                              style: AppTypography.caption(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
