import 'package:codeleek_core/ads/provider.dart';
import 'package:codeleek_core/core/utils/app_constants.dart';
import 'package:codeleek_core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:lottie/lottie.dart';
import 'package:codeleek_core/theme/colors.dart';
import 'package:codeleek_core/core/init/core_initializer.dart';
import 'package:codeleek_core/ads/ad_service.dart';
import 'package:codeleek_core/ui/widgets/game_progress_bar.dart';
import 'package:codeleek_core/core/init/initialization_notifier.dart';

class CoreLoadingScreen extends ConsumerStatefulWidget {
  // Change to ConsumerStatefulWidget
  final VoidCallback onInitializationComplete;

  const CoreLoadingScreen({super.key, required this.onInitializationComplete});

  @override
  ConsumerState<CoreLoadingScreen> createState() => _CoreLoadingScreenState();
}

class _CoreLoadingScreenState extends ConsumerState<CoreLoadingScreen> {
  // Change the state class
  final InitializationNotifier _notifier = InitializationNotifier();

  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    // Read the CoreConfig directly from the provider
    final config = ref.read(coreConfigProvider);

    // Step 1: Initialize Core services (Firebase, AdMob, etc.)
    _notifier.updateProgress(0.1, 'Initializing core services...');
    await CoreInitializer.initialize(config: config);

    // Step 2: Initialize Ad services
    _notifier.updateProgress(0.3, 'Initializing Ad Services...');
    AdService.initialize(config);
    AdService.loadInterstitialAd();
    AdService.loadRewardedAd();

    // Step 3: Simulate other game-specific loading tasks
    _notifier.updateProgress(0.5, 'Loading game assets...');
    await Future.delayed(const Duration(seconds: 1));

    _notifier.updateProgress(0.7, 'Setting up audio engine...');
    await Future.delayed(const Duration(seconds: 1));

    _notifier.updateProgress(0.9, 'Preparing UI components...');
    await Future.delayed(const Duration(seconds: 1));

    // Step 4: All done!
    _notifier.updateProgress(1.0, 'Initialization complete!');
    await Future.delayed(const Duration(milliseconds: 500));

    // Notify the parent widget that loading is complete
    widget.onInitializationComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoreColors.darkBackground,
      body: Center(
        child: AnimatedBuilder(
          animation: _notifier,
          builder: (context, child) {
            final progress = _notifier.state.progress;
            final message = _notifier.state.message;
            return LayoutBuilder(
              builder: (context, constraints) {
                final bool isLandscape =
                    constraints.maxWidth > constraints.maxHeight;
                if (isLandscape) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'iconHeroTag', // Choose a unique tag for this specific icon
                          child: Lottie.asset(
                            CoreConstants.appLogoMotion,
                            width: constraints.maxHeight * 0.7,
                            repeat: true,
                            package: CoreConstants.codeleekCorePackage,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GameProgressBar(
                                progress: progress,
                                backgroundColor: CoreColors.lightBackground,
                                fillColor: CoreColors.darkBackground,
                                borderColor: CoreColors.lightBackground,
                              ),
                              SizedBox(height: 20),
                              Text(
                                message,
                                style: CoreTypography.buttonText,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                        CoreConstants.appLogoMotion,
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        repeat: true,
                        package: CoreConstants.codeleekCorePackage,
                      ),
                      Column(
                        children: [
                          GameProgressBar(
                            progress: progress,
                            backgroundColor: CoreColors.lightBackground,
                            fillColor: CoreColors.darkBackground,
                            borderColor: CoreColors.lightBackground,
                          ),
                          SizedBox(height: 20),
                          Text(
                            message,
                            style: CoreTypography.buttonText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
