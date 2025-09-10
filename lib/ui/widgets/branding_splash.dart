import 'dart:async';

import 'package:codeleek_core/core/utils/app_constants.dart';
import 'package:codeleek_core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:codeleek_core/theme/colors.dart';

class BrandingSplash extends StatefulWidget {
  final String? appName;
  final VoidCallback onAnimationComplete;

  const BrandingSplash({
    Key? key,
    this.appName,
    required this.onAnimationComplete,
  }) : super(key: key);

  @override
  _BrandingSplashState createState() => _BrandingSplashState();
}

class _BrandingSplashState extends State<BrandingSplash> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the fade-in animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Set a timer to call the callback after a delay
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onAnimationComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the text to display. Use the provided appName or the default brand.
    final String textToDisplay = widget.appName ?? "Codeleek";

    return Scaffold(
      backgroundColor: CoreColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The brand logo remains static
            // Image(image: AssetImage(AppConstants.appLogoSrc)),
            Hero(
              tag: 'iconHeroTag', // Choose a unique tag for this specific icon
              child: Image.asset(
                CoreConstants.appLogoSrc,
                width: 200,
                height: 200,
                package: CoreConstants.codeleekCorePackage,
              ),
            ),
            const SizedBox(height: 20),
            // Use an AnimatedOpacity widget for the fade-in effect
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2), // The animation duration
              child: Text(textToDisplay, style: CoreTypography.headline1),
            ),
          ],
        ),
      ),
    );
  }
}
