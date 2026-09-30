import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Ultra dark sleek background
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceElevated = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF262626);
  static const Color border = Color(0xFF262626);
  static const Color borderSubtle = Color(0xFF333333);

  // Vibrant neon greens and teals
  static const Color primary = Color(0xFF50DB5E);
  static const Color primaryDark = Color(0xFF00C950);
  static const Color secondary = Color(0xFF14D7C9);
  static const Color secondaryDark = Color(0xFF00BBA7);
  
  // Neon accents
  static const Color neonGreen = Color(0xFF7DFF33);
  static const Color neonTeal = Color(0xFF14D7C9);
  static const Color accentOrange = Color(0xFFFF6900);
  static const Color accentRed = Color(0xFFFB2C36);
  static const Color accentYellow = Color(0xFFFACC15);
  static const Color accentBlue = Color(0xFF60A5FA);

  // Text colors
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA7A7A7);
  static const Color textMuted = Color(0xFF737373);
  static const Color textDark = Color(0xFF0A0A0A);

  // Gradients matching Figma
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF50DB5E), Color(0xFF14D7C9)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient reversePrimaryGradient = LinearGradient(
    colors: [Color(0xFF14D7C9), Color(0xFF50DB5E)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardOverlayGradient = LinearGradient(
    colors: [Colors.transparent, Color(0xFF0A0A0A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1C1F24), Color(0xFF121417)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF0A0A0A), Color(0xFF152219), Color(0xFF0A0A0A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Glow box shadow
  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: const Color(0xFF32D993).withValues(alpha: 0.35),
      blurRadius: 30,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}

class AppTypography {
  // Orbitron for high-tech brand headlines & metrics
  static TextStyle displayBold({double fontSize = 28, Color color = AppColors.textPrimary}) {
    return GoogleFonts.orbitron(
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle displayMedium({double fontSize = 22, Color color = AppColors.textPrimary}) {
    return GoogleFonts.orbitron(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // Plus Jakarta Sans for ultra-modern UI titles & body
  static TextStyle titleBold({double fontSize = 20, Color color = AppColors.textPrimary}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle titleSemibold({double fontSize = 17, Color color = AppColors.textPrimary}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle bodyMedium({double fontSize = 14, Color color = AppColors.textPrimary, double height = 1.4}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
    );
  }

  static TextStyle bodyRegular({double fontSize = 14, Color color = AppColors.textSecondary, double height = 1.4}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      height: height,
    );
  }

  static TextStyle caption({double fontSize = 12, Color color = AppColors.textMuted}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle juraSubtitle({double fontSize = 15, Color color = AppColors.textSecondary}) {
    return GoogleFonts.jura(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.35,
    );
  }
}

ThemeData getAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
  );
}
