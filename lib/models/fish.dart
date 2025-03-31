import 'package:flutter/material.dart';

class AnimatedFish extends StatefulWidget {
  final Color color;
  final double speed;

  AnimatedFish({required this.color, required this.speed});

  @override
  _AnimatedFishState createState() => _AnimatedFishState();
}

class _AnimatedFishState extends State<AnimatedFish> with TickerProviderStateMixin {
  late AnimationController _controller;
  late double _leftPosition;
  late double _topPosition;
  late double _dx;
  late double _dy;

  @override
  void initState() {
    super.initState();

    _leftPosition = 0.0;
    _topPosition = 0.0;
    _dx = widget.speed;
    _dy = widget.speed;

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..addListener(_updatePosition);

    _controller.repeat();
  }

  void _updatePosition() {
    setState(() {
      _leftPosition += _dx;
      _topPosition += _dy;

      if (_leftPosition >= 300 || _leftPosition <= 0) {
        _dx = -_dx;
      }

      if (_topPosition >= 300 || _topPosition <= 0) {
        _dy = -_dy;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _leftPosition,
      top: _topPosition,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: widget.color,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
