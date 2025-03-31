import 'dart:math';
import 'package:flutter/material.dart';
import '../models/fish.dart';

class AnimatedFish extends StatefulWidget {
  final Fish fish;
  const AnimatedFish({required this.fish, super.key});

  @override
  _AnimatedFishState createState() => _AnimatedFishState();
}

class _AnimatedFishState extends State<AnimatedFish> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double leftPosition;
  late double topPosition;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    leftPosition = _random.nextDouble() * 280;
    topPosition = _random.nextDouble() * 280;

    _controller = AnimationController(
      duration: Duration(seconds: widget.fish.speed.toInt()),
      vsync: this,
    )..repeat();

    _controller.addListener(() {
      setState(() {
        leftPosition += (_random.nextBool() ? 1 : -1) * widget.fish.speed;
        topPosition += (_random.nextBool() ? 1 : -1) * widget.fish.speed;
        leftPosition = leftPosition.clamp(0, 280);
        topPosition = topPosition.clamp(0, 280);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: leftPosition,
      top: topPosition,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: widget.fish.color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
