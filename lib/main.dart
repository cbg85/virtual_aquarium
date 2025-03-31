import 'package:flutter/material.dart';
import 'screens/aquarium_screen.dart';

void main() {
  runApp(const VirtualAquariumApp());
}

class VirtualAquariumApp extends StatelessWidget {
  const VirtualAquariumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtual Aquarium',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AquariumScreen(),
    );
  }
}
