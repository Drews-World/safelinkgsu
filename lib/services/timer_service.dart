import 'dart:async';

class TimerService {
  Timer? _timer;

  /// Starts a safety timer that triggers a callback when time is up
  void startSafetyTimer(Duration duration, void Function() onTimeout) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(duration, onTimeout); // Start a new timer with the callback
  }

  /// Cancels the safety timer
  void cancelTimer() {
    _timer?.cancel();
  }
}