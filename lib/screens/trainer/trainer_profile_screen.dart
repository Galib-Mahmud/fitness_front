import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../auth/sign_in_screen.dart';

class TrainerProfileScreen extends StatefulWidget {
  final VoidCallback onSwitchRole;

  const TrainerProfileScreen({
    super.key,
    required this.onSwitchRole,
  });

  @override
  State<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
  String _hourlyRate = '65';
  final List<String> _specialties = ['Weight loss', 'Muscle building', 'Strength training'];

  void _showEditProfileModal(BuildContext context) {
    final rateController = TextEditingController(text: _hourlyRate);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 28),
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
              'Edit Coach Profile',
              style: AppTypography.displayBold(fontSize: 20, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Text('Hourly Rate (\$ / hr)', style: AppTypography.caption(color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: rateController,
                keyboardType: TextInputType.number,
                style: AppTypography.titleBold(color: AppColors.primary),
                decoration: const InputDecoration(border: InputBorder.none, isDense: true),
              ),
            ),
            const SizedBox(height: 20),
            NeonButton(
              text: 'Save Changes',
              onPressed: () {
                setState(() => _hourlyRate = rateController.text);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FigmaStatusBar(),
              const SizedBox(height: 12),

              // Trainer Header (Figma #1:6878)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary, width: 3),
                              boxShadow: AppColors.primaryGlow,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/edit_profile_avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () => _showEditProfileModal(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit_rounded,
                                  size: 14,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Coach Alex Rivera',
                      style: AppTypography.displayBold(
                        fontSize: 22,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '4 sessions this Week',
                      style: AppTypography.bodyRegular(
                        fontSize: 13,
                        color: AppColors.secondary,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Stats Row
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('18', 'Clients', AppColors.textPrimary),
                          Container(width: 1, height: 32, color: AppColors.border),
                          _buildStatItem('★ 4.9', 'Rating', AppColors.accentYellow),
                          Container(width: 1, height: 32, color: AppColors.border),
                          _buildStatItem('\$$_hourlyRate', 'Per Hour', AppColors.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Switch to Client Mode Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: widget.onSwitchRole,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF263328), Color(0xFF141A16)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.person_search_rounded,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Switch to Client Portal',
                                style: AppTypography.titleBold(
                                  fontSize: 15,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Find trainers and book training sessions',
                                style: AppTypography.bodyRegular(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Specialties Section (Figma #1:6878: "Specialties", "Weight loss", "Muscle building", "Strength training")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Specialties',
                          style: AppTypography.titleBold(
                            fontSize: 17,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showEditProfileModal(context),
                          child: Text(
                            'Edit',
                            style: AppTypography.titleSemibold(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _specialties.map((spec) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border, width: 1),
                          ),
                          child: Text(
                            spec,
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

              // Business Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.tune_rounded, color: AppColors.primary),
                        title: Text('Edit Profile & Pricing', style: AppTypography.titleSemibold(fontSize: 14, color: AppColors.textPrimary)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                        onTap: () => _showEditProfileModal(context),
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      ListTile(
                        leading: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.primary),
                        title: Text('Payouts & Direct Deposit', style: AppTypography.titleSemibold(fontSize: 14, color: AppColors.textPrimary)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                        onTap: () {},
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      ListTile(
                        leading: const Icon(Icons.verified_user_outlined, color: AppColors.primary),
                        title: Text('Trainer Certifications', style: AppTypography.titleSemibold(fontSize: 14, color: AppColors.textPrimary)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign Out
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SecondaryDarkButton(
                  text: 'Sign out',
                  textColor: AppColors.accentRed,
                  backgroundColor: AppColors.surfaceElevated,
                  borderColor: AppColors.accentRed.withValues(alpha: 0.3),
                  icon: const Icon(Icons.logout_rounded, size: 18, color: AppColors.accentRed),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String val, String label, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: AppTypography.displayBold(
            fontSize: 20,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.caption(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
