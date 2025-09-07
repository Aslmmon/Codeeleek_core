import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:codeleek_core/core/config/core_config.dart';

class CoreInitializer {
  /// Initializes all core dependencies like Firebase and Google Ads.
  static Future<void> initialize({required CoreConfig config}) async {
    // 1. Initialize Firebase if configurations are provided
    if (config.firebaseAppId != null) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: config.firebaseApiKey!,
          appId: config.firebaseAppId!,
          messagingSenderId: config.firebaseMessagingSenderId!,
          projectId: config.firebaseProjectId!,
        ),
      );
    }

    // 2. Initialize Google Mobile Ads if ID is provided
    if (config.admobAppId != null && !kIsWeb) {
      await MobileAds.instance.initialize();
      // Optional: Request a test ad to ensure everything is working
      // MobileAds.instance.updateRequestConfiguration(
      //   RequestConfiguration(testDeviceIds: ['YOUR_TEST_DEVICE_ID']),
      // );
    }

    // You can add more initializers here, e.g., Crashlytics, etc.
  }
}
