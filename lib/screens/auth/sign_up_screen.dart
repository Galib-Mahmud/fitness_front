import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../main_wrapper.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AppRole _selectedRole = AppRole.client;
  bool _showForm = false;

  final _nameController = TextEditingController(text: 'Alex Johnson');
  final _emailController = TextEditingController(text: 'alex.johnson@gmail.com');
  final _phoneController = TextEditingController(text: '+1 (555) 019-2834');
  final _passwordController = TextEditingController(text: '••••••••••••');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onCompleteSignUp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => MainWrapper(initialRole: _selectedRole),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FigmaStatusBar(),
              const SizedBox(height: 12),

              // Back button
              GestureDetector(
                onTap: () {
                  if (_showForm) {
                    setState(() => _showForm = false);
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Brand header tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
                ),
                child: Text(
                  'Welcome to TrainerMatch',
                  style: AppTypography.displayMedium(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              if (!_showForm) ...[
                // Role Selection Header
                Text(
                  'I am a…',
                  style: AppTypography.displayBold(
                    fontSize: 32,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your role to personalise your experience',
                  style: AppTypography.bodyRegular(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                // Role Card 1: Client
                _buildRoleCard(
                  role: AppRole.client,
                  icon: Icons.search_rounded,
                  title: "I'm Looking for a Trainer",
                  description: 'Find certified trainers matched to your goals, schedule, and budget.',
                  actionText: 'Get matched',
                ),

                const SizedBox(height: 18),

                // Role Card 2: Trainer
                _buildRoleCard(
                  role: AppRole.trainer,
                  icon: Icons.sports_rounded,
                  title: "I'm a Trainer",
                  description: 'Grow your client base, manage schedules, and train clients your way.',
                  actionText: 'Get started',
                ),

                const SizedBox(height: 36),

                // Continue Button
                NeonButton(
                  text: 'Continue',
                  onPressed: () {
                    setState(() => _showForm = true);
                  },
                ),
              ] else ...[
                // Account creation form
                Text(
                  'Create Account',
                  style: AppTypography.displayBold(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedRole == AppRole.client
                      ? 'Find top certified coaches and transform your life.'
                      : 'Build your coaching business and connect with clients.',
                  style: AppTypography.bodyRegular(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 28),

                _buildInputLabel('Full Name'),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _nameController,
                  hintText: 'John Doe',
                  prefixIcon: Icons.person_outline_rounded,
                ),

                const SizedBox(height: 18),

                _buildInputLabel('Email Address'),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _emailController,
                  hintText: 'john@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                _buildInputLabel('Phone Number'),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _phoneController,
                  hintText: '+1 (555) 000-0000',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 18),

                _buildInputLabel('Password'),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _passwordController,
                  hintText: 'Create a password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: true,
                ),

                const SizedBox(height: 28),

                NeonButton(
                  text: 'Complete Registration',
                  onPressed: _onCompleteSignUp,
                ),
              ],

              const SizedBox(height: 32),

              // Already have an account link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: AppTypography.bodyRegular(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: AppTypography.titleSemibold(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required AppRole role,
    required IconData icon,
    required String title,
    required String description,
    required String actionText,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRole = role);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2420) : AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppColors.primaryGlow : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: isSelected ? AppColors.textDark : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.textMuted,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: AppColors.textDark)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTypography.titleBold(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: AppTypography.bodyRegular(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  actionText,
                  style: AppTypography.titleSemibold(
                    fontSize: 13,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: AppTypography.titleSemibold(
        fontSize: 13,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTypography.bodyMedium(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.bodyRegular(color: AppColors.textMuted),
            prefixIcon: Icon(prefixIcon, color: AppColors.textMuted, size: 20),
            prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 20),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
