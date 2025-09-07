import 'package:flutter/material.dart';
import 'package:codeleek_core/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreTypography {
  // Use a getter to access the Lilita One text theme.
  // This provides a base theme with the font applied.
  static TextTheme get _lilitaOneTextTheme => GoogleFonts.lilitaOneTextTheme();

  static final TextStyle headline1 = _lilitaOneTextTheme.headlineLarge!
      .copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CoreColors.lightText,
      );

  static final TextStyle bodyText1 = _lilitaOneTextTheme.bodyMedium!.copyWith(
    fontSize: 16,
    color: CoreColors.darkText,
  );

  static final TextStyle buttonText = _lilitaOneTextTheme.labelLarge!.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: CoreColors.lightText,
  );
}
