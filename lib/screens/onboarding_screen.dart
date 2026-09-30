import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'auth/sign_in_screen.dart';
import 'auth/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final String _currentLanguage = 'ENG';

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Find Your Perfect Match',
      subtitle: 'Not all trainers are the same. Tell us about yourself so we can find the coach who gets you.',
      ctaText: 'Continue',
    ),
    _OnboardingPageData(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'What Drives You?',
      subtitle: 'Share your fitness goals and preferences. The more we know, the better we pair you.',
      ctaText: 'Continue',
    ),
    _OnboardingPageData(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Meet Your Coach',
      subtitle: 'Browse your personalized trainer recommendations and choose who inspires you most.',
      ctaText: 'Continue',
    ),
    _OnboardingPageData(
      imagePath: 'assets/images/onboarding_4.png',
      title: 'Book Your Season',
      subtitle: 'Reserve your sessions in one tap. Your transformation starts now.',
      ctaText: 'Continue',
    ),
    _OnboardingPageData(
      imagePath: 'assets/images/onboarding_5.png',
      title: 'Your fitness journey\nstarts here',
      subtitle: 'Connect with certified trainers matched\nto your goals, schedule, and budget.',
      ctaText: 'Create Account',
      isFinalStep: true,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background PageView with Photos
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    page.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.darkCardGradient,
                        ),
                      );
                    },
                  ),
                  // Dark gradient overlay matching Figma linear-gradient(180deg, rgba(10, 10, 10, 0) 0%, rgba(10, 10, 10, 1) 78%)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.3),
                          AppColors.background.withValues(alpha: 0.85),
                          AppColors.background,
                        ],
                        stops: const [0.0, 0.45, 0.72, 0.95],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Top status bar & Language selector pill
          SafeArea(
            child: Column(
              children: [
                const FigmaStatusBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button if not on first page
                      if (_currentPage > 0)
                        GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border, width: 1),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 18,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 40),

                      // Language selector matching Figma
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Language : ',
                              style: AppTypography.caption(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              _currentLanguage,
                              style: AppTypography.titleBold(
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon badge (Figma EL-07ddd9f9)
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppColors.primaryGlow,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.fitness_center_rounded,
                        size: 28,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    _pages[_currentPage].title,
                    textAlign: TextAlign.center,
                    style: AppTypography.displayBold(
                      fontSize: 26,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    _pages[_currentPage].subtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.juraSubtitle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Pagination Progress Indicators (4-5 dashes from Figma)
                  if (!_pages[_currentPage].isFinalStep) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 32 : 10,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primary : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: isActive ? AppColors.primaryGlow : null,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action Buttons
                  if (_pages[_currentPage].isFinalStep) ...[
                    NeonButton(
                      text: 'Create Account',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SecondaryDarkButton(
                      text: 'Sign In',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        );
                      },
                    ),
                  ] else ...[
                    NeonButton(
                      text: _pages[_currentPage].ctaText,
                      onPressed: _nextPage,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: AppTypography.bodyRegular(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String ctaText;
  final bool isFinalStep;

  const _OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.ctaText,
    this.isFinalStep = false,
  });
}
