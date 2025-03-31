import 'package:flutter/material.dart';
import '../models/fish.dart';
import '../widgets/animated_fish.dart';
import '../services/local_storage.dart';

class AquariumScreen extends StatefulWidget {
  const AquariumScreen({super.key});

  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen> {
  List<Fish> fishList = [];
  Color selectedColor = Colors.orange;
  double fishSpeed = 2.0;

  @override
  void initState() {
    super.initState();
    _loadSavedSettings();
  }

  void _loadSavedSettings() async {
    var settings = await LocalStorage.loadSettings();
    setState(() {
      fishList = settings.fishList;
      fishSpeed = settings.fishSpeed;
      selectedColor = settings.fishColor;
    });
  }

  void _addFish() {
    if (fishList.length < 10) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: fishSpeed));
      });
    }
  }

  void _saveSettings() {
    LocalStorage.saveSettings(fishList, fishSpeed, selectedColor);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Aquarium")),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            color: Colors.blue[100],
            child: Stack(children: fishList.map((fish) => AnimatedFish(fish: fish)).toList()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _addFish, child: const Text("Add Fish")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: _saveSettings, child: const Text("Save Settings")),
            ],
          ),
          Slider(
            value: fishSpeed,
            min: 1.0,
            max: 5.0,
            divisions: 4,
            label: fishSpeed.toString(),
            onChanged: (value) => setState(() => fishSpeed = value),
          ),
          DropdownButton<Color>(
            value: selectedColor,
            items: [
              DropdownMenuItem(value: Colors.orange, child: Container(width: 20, height: 20, color: Colors.orange)),
              DropdownMenuItem(value: Colors.red, child: Container(width: 20, height: 20, color: Colors.red)),
              DropdownMenuItem(value: Colors.green, child: Container(width: 20, height: 20, color: Colors.green)),
              DropdownMenuItem(value: Colors.blue, child: Container(width: 20, height: 20, color: Colors.blue)),
            ],
            onChanged: (color) => setState(() => selectedColor = color!),
          ),
        ],
      ),
    );
  }
}
