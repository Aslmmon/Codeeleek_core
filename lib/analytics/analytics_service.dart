import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // A method to log a custom event with optional parameters.
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
    print('Analytics: Logged event "$name"'); // For debugging purposes
  }

  // A method to set a user ID.
  Future<void> setUserId(String id) async {
    await _analytics.setUserId(id: id);
    print('Analytics: Set user ID to "$id"');
  }

  // Example of a specific, common event.
  Future<void> logLevelStart(String levelName) async {
    await _analytics.logEvent(
      name: 'level_start',
      parameters: {'level_name': levelName},
    );
  }
}
