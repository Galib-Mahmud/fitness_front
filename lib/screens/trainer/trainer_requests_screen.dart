import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/client_request.dart';
import '../../widgets/common_widgets.dart';

class TrainerRequestsScreen extends StatefulWidget {
  const TrainerRequestsScreen({super.key});

  @override
  State<TrainerRequestsScreen> createState() => _TrainerRequestsScreenState();
}

class _TrainerRequestsScreenState extends State<TrainerRequestsScreen> {
  int _selectedTab = 0; // 0 = All, 1 = New, 2 = Renew (1), 3 = Archive
  String _searchQuery = '';

  final List<String> _tabs = ['All', 'New', 'Renew (1)', 'Archive'];

  @override
  Widget build(BuildContext context) {
    final allRequests = ClientRequest.sampleRequests;
    final filtered = allRequests.where((req) {
      final matchesQuery = req.clientName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          req.goal.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesQuery) return false;

      if (_selectedTab == 0) return true;
      if (_selectedTab == 1) return req.category == RequestCategory.newReq;
      if (_selectedTab == 2) return req.category == RequestCategory.renew;
      if (_selectedTab == 3) return req.category == RequestCategory.archive;
      return true;
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

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Client Requests',
                  style: AppTypography.displayBold(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FigmaSearchBar(
                  hintText: 'Search requests or clients...',
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),

              const SizedBox(height: 18),

              // Tabs Slider matching Figma (All, New, Renew (1), Archive)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomSliderTabs(
                  tabs: _tabs,
                  selectedIndex: _selectedTab,
                  onTabChanged: (idx) => setState(() => _selectedTab = idx),
                ),
              ),

              const SizedBox(height: 20),

              // Requests List
              if (filtered.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox_rounded,
                          size: 48,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No requests in this category',
                          style: AppTypography.titleSemibold(
                            fontSize: 15,
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
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final req = filtered[index];
                    return _buildRequestCard(context, req);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, ClientRequest req) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: req.category == RequestCategory.renew
              ? AppColors.secondary.withValues(alpha: 0.4)
              : AppColors.border,
          width: 1,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Client Name, Category Badge
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(req.avatarPath),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      req.clientName,
                      style: AppTypography.titleBold(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      req.goal,
                      style: AppTypography.bodyRegular(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: req.category == RequestCategory.renew
                      ? AppColors.secondary.withValues(alpha: 0.15)
                      : AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: req.category == RequestCategory.renew ? AppColors.secondary : AppColors.primary,
                    width: 1,
                  ),
                ),
                child: Text(
                  req.category == RequestCategory.renew ? 'RENEWAL' : 'NEW REQUEST',
                  style: AppTypography.caption(
                    fontSize: 10,
                    color: req.category == RequestCategory.renew ? AppColors.secondary : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),

          // Requested schedule & Budget info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.schedule_rounded, size: 15, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    req.requestedTime,
                    style: AppTypography.caption(fontSize: 12, color: AppColors.textPrimary),
                  ),
                ],
              ),
              Text(
                '\$${req.budget.toInt()} (${req.sessionCount} sessions)',
                style: AppTypography.titleBold(
                  fontSize: 13,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Client Note
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '"${req.note}"',
              style: AppTypography.bodyRegular(
                fontSize: 12,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: SecondaryDarkButton(
                  text: 'Decline',
                  height: 42,
                  backgroundColor: AppColors.surfaceElevated,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Request from ${req.clientName} declined.')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeonButton(
                  text: 'Accept',
                  height: 42,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF1E2822),
                        content: Text('🎉 Accepted request from ${req.clientName}! Added to your schedule.'),
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
}
