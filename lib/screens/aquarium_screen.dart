import 'package:flutter/material.dart';
import 'package:virtual_aquarium/widgets/animated_fish.dart' as widgets;

class AquariumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Virtual Aquarium")),
      body: Center(
        child: widgets.AnimatedFish(
          color: Colors.blue,
          speed: 2.0,
        ),
      ),
    );
  }
}
