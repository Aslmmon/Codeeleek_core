import 'package:flutter/material.dart';

class InitializationState {
  final double progress;
  final String message;

  InitializationState({
    this.progress = 0.0,
    this.message = 'Initializing...',
  });
}

class InitializationNotifier extends ChangeNotifier {
  InitializationState _state = InitializationState();

  InitializationState get state => _state;

  void updateProgress(double progress, String message) {
    _state = InitializationState(progress: progress, message: message);
    notifyListeners();
  }
}