import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../main_wrapper.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController(text: 'alex.rivera@fitness.com');
  final _passwordController = TextEditingController(text: '••••••••••••');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainWrapper()),
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
                onTap: () => Navigator.of(context).maybePop(),
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

              const SizedBox(height: 32),

              // Headers
              Text(
                'Welcome Back',
                style: AppTypography.displayBold(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your credentials to continue your fitness journey.',
                style: AppTypography.bodyRegular(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 36),

              // Email Input Field
              _buildInputLabel('Email Address'),
              const SizedBox(height: 8),
              _buildInputField(
                controller: _emailController,
                hintText: 'name@example.com',
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Input Field
              _buildInputLabel('Password'),
              const SizedBox(height: 8),
              _buildInputField(
                controller: _passwordController,
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),

              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: AppTypography.caption(
                      fontSize: 13,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Sign in CTA
              NeonButton(
                text: 'Sign In',
                onPressed: _onSignIn,
              ),

              const SizedBox(height: 32),

              // Divider "Or continue with"
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or continue with',
                      style: AppTypography.caption(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                ],
              ),

              const SizedBox(height: 24),

              // Social Sign-in Buttons matching Figma
              Row(
                children: [
                  Expanded(
                    child: SecondaryDarkButton(
                      text: 'Google',
                      backgroundColor: AppColors.surfaceElevated,
                      icon: SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 20,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.g_mobiledata, size: 24, color: AppColors.textPrimary),
                      ),
                      onPressed: _onSignIn,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SecondaryDarkButton(
                      text: 'Apple',
                      backgroundColor: AppColors.surfaceElevated,
                      icon: SvgPicture.asset(
                        'assets/icons/apple.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.apple, size: 24, color: AppColors.textPrimary),
                      ),
                      onPressed: _onSignIn,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Don't have an account link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppTypography.bodyRegular(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
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
    Widget? suffixIcon,
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
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
