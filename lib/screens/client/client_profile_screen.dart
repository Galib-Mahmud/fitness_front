import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../auth/sign_in_screen.dart';

class ClientProfileScreen extends StatefulWidget {
  final VoidCallback onSwitchRole;

  const ClientProfileScreen({
    super.key,
    required this.onSwitchRole,
  });

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  bool _notificationsEnabled = true;

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

              // Profile Header Card (Figma #1:8384)
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
                                image: AssetImage('assets/images/client_profile_avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Alex Johnson',
                      style: AppTypography.displayBold(
                        fontSize: 22,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '4 sessions this month',
                      style: AppTypography.bodyRegular(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Stats Row (Figma #1:8397)
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
                          _buildStatItem('12', 'Sessions', AppColors.primary),
                          Container(width: 1, height: 32, color: AppColors.border),
                          _buildStatItem('3', 'Trainers', AppColors.textPrimary),
                          Container(width: 1, height: 32, color: AppColors.border),
                          _buildStatItem('5', 'Streak 🔥', AppColors.accentOrange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Switch to Trainer Mode Banner
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
                            Icons.sports_rounded,
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
                                'Switch to Trainer Portal',
                                style: AppTypography.titleBold(
                                  fontSize: 15,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Manage clients, schedule, and requests',
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

              const SizedBox(height: 28),

              // Account Section (Figma #1:8409)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Account',
                  style: AppTypography.displayMedium(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Menu list (Figma #1:8411)
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
                      _buildMenuItem(
                        icon: Icons.person_outline_rounded,
                        title: 'Personal Information',
                        onTap: () {},
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      _buildMenuItem(
                        icon: Icons.favorite_border_rounded,
                        title: 'Favourite trainers',
                        onTap: () {},
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      _buildMenuItem(
                        icon: Icons.notifications_none_rounded,
                        title: 'Notifications',
                        trailing: Switch(
                          value: _notificationsEnabled,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) => setState(() => _notificationsEnabled = val),
                        ),
                        onTap: () {},
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      _buildMenuItem(
                        icon: Icons.star_border_rounded,
                        title: 'My reviews',
                        onTap: () {},
                      ),
                      const Divider(color: AppColors.border, height: 1, indent: 56),
                      _buildMenuItem(
                        icon: Icons.credit_card_outlined,
                        title: 'Payment Methods',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Sign Out Button (Figma #1:8748)
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 18),
      ),
      title: Text(
        title,
        style: AppTypography.titleSemibold(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppColors.textMuted,
          ),
      onTap: onTap,
    );
  }
}
