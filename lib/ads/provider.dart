import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codeleek_core/core/config/core_config.dart';

// This provider holds the single instance of CoreConfig.
// It is initially set to `null` and must be overridden at the root of the app.
final coreConfigProvider = Provider<CoreConfig>((ref) {
  throw UnimplementedError(); // This ensures it must be overridden.
});