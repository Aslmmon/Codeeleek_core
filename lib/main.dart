import 'package:codeleek_core/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:codeleek_core/codeleek_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'ads/ad_service.dart';
import 'ads/banner_ad_widget.dart';
import 'ads/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  final coreConfig = CoreConfig(
    admobAppId: 'ca-app-pub-3940256099942544~3347511713',
    admobInterstitialAdUnitId: 'ca-app-pub-3940256099942544/1033173712',
    admobRewardedAdUnitId: 'ca-app-pub-3940256099942544/5224354917',
    admobBannerAdUnitId: 'ca-app-pub-3940256099942544/6300978111',
  );

  runApp(
    ProviderScope(
      overrides: [coreConfigProvider.overrideWithValue(coreConfig)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Project',
      // The app starts at the splash screen
      home: Builder(
        builder: (BuildContext builderContext) {
          // Use a new context provided by Builder
          return BrandingSplash(
            appName: "My Awesome Game" /* Optional custom app name */,
            onAnimationComplete: () {
              Navigator.push(
                builderContext,
                MaterialPageRoute(
                  builder:
                      (context) => CoreLoadingScreen(
                        onInitializationComplete: () {
                          print("finished");
                          Navigator.push(
                            builderContext,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coreConfig = ref.watch(coreConfigProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to the Game!',
                      style: CoreTypography.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'This is your game content.',
                      style: CoreTypography.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          BannerAdWidget(config: coreConfig),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AdService.showInterstitialAd();
        },
        child: const Icon(Icons.videocam),
      ),
    );
  }
}
