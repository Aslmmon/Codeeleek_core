// test/mocks/mock_core_config.dart

import 'package:codeleek_core/codeleek_core.dart';
import 'package:flutter/material.dart';

// Test IDs provided by Google
const String kTestBannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
const String kTestInterstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";
const String kTestRewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";

final mockConfig = CoreConfig(
  admobBannerAdUnitId: kTestBannerAdUnitId,
  admobInterstitialAdUnitId: kTestInterstitialAdUnitId,
  admobRewardedAdUnitId: kTestRewardedAdUnitId,
);