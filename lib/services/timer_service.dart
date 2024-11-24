import 'dart:async';

class TimerService {
  Timer? _timer;

 
  void startSafetyTimer(Duration duration, void Function() onTimeout) {
    _timer?.cancel(); 
    _timer = Timer(duration, onTimeout); 
  }

 
  void cancelTimer() {
    _timer?.cancel();
  }
}