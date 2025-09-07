import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:codeleek_core/core/config/core_config.dart';

class AdService {
  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;
  static CoreConfig? _config;

  static void initialize(CoreConfig config) {
    _config = config;
  }

  // Load an interstitial ad.
  static void loadInterstitialAd() {
    if (_config?.admobInterstitialAdUnitId == null) {
      print('Ad Service: No Interstitial Ad Unit ID found.');
      return;
    }

    InterstitialAd.load(
      adUnitId: _config!.admobInterstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          print('Ad Service: Interstitial ad loaded.');
        },
        onAdFailedToLoad: (error) {
          print('Ad Service: Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  // Show the loaded interstitial ad.
  static void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Ad Service: Interstitial ad not ready yet.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd(); // Load the next one
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad Service: Interstitial ad failed to show: $error');
        ad.dispose();
        _interstitialAd = null;
      },
    );
    _interstitialAd!.show();
  }

  // Load a rewarded ad.
  static void loadRewardedAd() {
    if (_config?.admobRewardedAdUnitId == null) {
      print('Ad Service: No Rewarded Ad Unit ID found.');
      return;
    }

    RewardedAd.load(
      adUnitId: _config!.admobRewardedAdUnitId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          print('Ad Service: Rewarded ad loaded.');
        },
        onAdFailedToLoad: (error) {
          print('Ad Service: Rewarded ad failed to load: $error');
        },
      ),
    );
  }

  // Show the loaded rewarded ad.
  static void showRewardedAd({required Function onReward}) {
    if (_rewardedAd == null) {
      print('Ad Service: Rewarded ad not ready yet.');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd(); // Load the next one
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Ad Service: Rewarded ad failed to show: $error');
        ad.dispose();
        _rewardedAd = null;
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        print('Ad Service: User earned reward!');
        onReward();
      },
    );
  }
}
