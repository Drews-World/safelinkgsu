import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _holdTimer;
  bool _isHolding = false;
  Color _backgroundColor = Colors.white;

  Timer? _flashingTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _holdTimer?.cancel();
    _flashingTimer?.cancel();
    super.dispose();
  }

  void _startHold() {
    setState(() {
      _isHolding = true;
    });
    _animationController.forward(); 
    _startFlashing(); 

    _holdTimer = Timer(const Duration(seconds: 8), () {
      if (_isHolding) {
       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'GSU Police have been alerted and dispatched to your location!',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      _resetHold();
    });
  }

  void _cancelHold() {
    if (_isHolding) {
      _resetHold();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emergency alert canceled.'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  void _resetHold() {
    setState(() {
      _isHolding = false;
      _backgroundColor = Colors.white; 
    });
    _animationController.reset();
    _holdTimer?.cancel();
    _flashingTimer?.cancel();
  }

  void _startFlashing() {
    _flashingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _backgroundColor =
            _backgroundColor == Colors.red ? Colors.blue : Colors.red;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Emergency'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: GestureDetector(
          onLongPressStart: (_) => _startHold(),
          onLongPressEnd: (_) => _cancelHold(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Tracing Circle
              CustomPaint(
                size: const Size(200, 200),
                painter: CirclePainter(
                  animationValue: _animationController.value,
                ),
              ),
              // Emergency Button
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    'HOLD\nFOR HELP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CirclePainter extends CustomPainter {
  final double animationValue;

  CirclePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    
    canvas.drawArc(
      rect,
      -pi / 2, 
      2 * pi * animationValue, 
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}