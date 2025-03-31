import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedFish extends StatefulWidget {
  final Color color;
  final double speed;

  const AnimatedFish({required this.color, required this.speed, Key? key}) : super(key: key);

  @override
  _AnimatedFishState createState() => _AnimatedFishState();
}

class _AnimatedFishState extends State<AnimatedFish> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  double _xPosition = 0;
  double _yPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.speed.toInt()),
      vsync: this,
    )..repeat();

    _xAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _yAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _xAnimation.addListener(() {
      setState(() {
        _xPosition = _xAnimation.value * 300; // Container width limit
      });
    });

    _yAnimation.addListener(() {
      setState(() {
        _yPosition = _yAnimation.value * 300; // Container height limit
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _xPosition,
      top: _yPosition,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

