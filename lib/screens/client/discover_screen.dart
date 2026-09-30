import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/trainer.dart';
import '../../widgets/common_widgets.dart';
import 'trainer_detail_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filterTags = [
    'All',
    'Strength',
    'Yoga',
    'HIIT',
    'CrossFit',
    'Top Rated',
    '< 2 Miles',
  ];

  @override
  Widget build(BuildContext context) {
    final allTrainers = Trainer.sampleTrainers;
    final filteredTrainers = allTrainers.where((t) {
      final matchesQuery = t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.specialty.toLowerCase().contains(_searchQuery.toLowerCase());
      if (_selectedFilter == 'All') return matchesQuery;
      if (_selectedFilter == 'Top Rated') return matchesQuery && t.rating >= 4.9;
      if (_selectedFilter == '< 2 Miles') return matchesQuery && t.distanceMi < 2.0;
      return matchesQuery && (t.specialty.contains(_selectedFilter) || t.skills.contains(_selectedFilter));
    }).toList();

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

              // Header (Figma #1:7917)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning 👋',
                            style: AppTypography.caption(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Discover Trainers',
                            style: AppTypography.displayBold(
                              fontSize: 26,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Highlighted match preferences from Figma
                          RichText(
                            text: TextSpan(
                              text: '10 ',
                              style: AppTypography.titleBold(
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                              children: [
                                TextSpan(
                                  text: 'trainers ',
                                  style: AppTypography.bodyRegular(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                TextSpan(
                                  text: 'match ',
                                  style: AppTypography.titleBold(
                                    fontSize: 13,
                                    color: AppColors.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: 'your preferences',
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
                    ),

                    // Notification bell
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 22,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FigmaSearchBar(
                  hintText: 'Search by specialty, location or name...',
                  onChanged: (val) {
                    setState(() => _searchQuery = val);
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Filter Chips
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filterTags.length,
                  itemBuilder: (context, index) {
                    final tag = _filterTags[index];
                    final isSelected = _selectedFilter == tag;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = tag),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
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
                          tag,
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

              // Featured Trainer Hero Card (Figma #1:7928)
              if (_selectedFilter == 'All' && _searchQuery.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildFeaturedTrainerCard(context, allTrainers[0]),
                ),

              const SizedBox(height: 24),

              // Matched Trainers Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Matches (${filteredTrainers.length})',
                      style: AppTypography.titleBold(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Sort: Best Match',
                      style: AppTypography.caption(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // List of Trainers
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredTrainers.length,
                itemBuilder: (context, index) {
                  final trainer = filteredTrainers[index];
                  return _buildTrainerListItem(context, trainer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedTrainerCard(BuildContext context, Trainer trainer) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TrainerDetailScreen(trainer: trainer),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Photo with 96% Match pill
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/discover_featured_trainer.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        trainer.bannerPath,
                        fit: BoxFit.cover,
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
                          AppColors.surface.withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          'TOP MATCH (96%)',
                          style: AppTypography.displayBold(
                            fontSize: 11,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trainer.name,
                            style: AppTypography.titleBold(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            trainer.specialty,
                            style: AppTypography.bodyRegular(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: '\$${trainer.hourlyRate}',
                          style: AppTypography.displayBold(
                            fontSize: 22,
                            color: AppColors.primary,
                          ),
                          children: [
                            TextSpan(
                              text: '/hr',
                              style: AppTypography.caption(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Rating, Distance, Certs row
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: AppColors.accentYellow),
                      const SizedBox(width: 4),
                      Text(
                        '${trainer.rating}',
                        style: AppTypography.titleBold(fontSize: 13, color: AppColors.textPrimary),
                      ),
                      Text(
                        ' (${trainer.reviewsCount} reviews)',
                        style: AppTypography.caption(fontSize: 12, color: AppColors.textMuted),
                      ),
                      const SizedBox(width: 14),
                      const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textMuted),
                      const SizedBox(width: 3),
                      Text(
                        '${trainer.distanceMi} mi away',
                        style: AppTypography.caption(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Specialty Pills (Figma #1:7955)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: trainer.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Text(
                          skill,
                          style: AppTypography.caption(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 18),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryDarkButton(
                          text: 'View Profile',
                          height: 46,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TrainerDetailScreen(trainer: trainer),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NeonButton(
                          text: 'Book Now',
                          height: 46,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TrainerDetailScreen(trainer: trainer),
                              ),
                            );
                          },
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

  Widget _buildTrainerListItem(BuildContext context, Trainer trainer) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TrainerDetailScreen(trainer: trainer),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            // Trainer avatar
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: AssetImage(trainer.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Trainer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          trainer.name,
                          style: AppTypography.titleBold(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${trainer.hourlyRate}/hr',
                        style: AppTypography.titleBold(
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    trainer.specialty,
                    style: AppTypography.bodyRegular(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: AppColors.accentYellow),
                      const SizedBox(width: 3),
                      Text(
                        '${trainer.rating}',
                        style: AppTypography.titleBold(fontSize: 12, color: AppColors.textPrimary),
                      ),
                      Text(
                        ' (${trainer.reviewsCount})',
                        style: AppTypography.caption(fontSize: 11, color: AppColors.textMuted),
                      ),
                      const SizedBox(width: 10),
                      Text('•', style: TextStyle(color: AppColors.textMuted)),
                      const SizedBox(width: 10),
                      Text(
                        '${trainer.distanceMi} mi away',
                        style: AppTypography.caption(fontSize: 11, color: AppColors.textSecondary),
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
