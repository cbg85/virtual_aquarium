import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/fish.dart';

class LocalStorage {
  static Future<void> saveSettings(List<Fish> fishList, double fishSpeed, Color fishColor) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('fish_count', fishList.length);
    prefs.setDouble('fish_speed', fishSpeed);
    prefs.setInt('fish_color', fishColor.value);
  }

  static Future<AquariumSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    int fishCount = prefs.getInt('fish_count') ?? 0;
    double fishSpeed = prefs.getDouble('fish_speed') ?? 2.0;
    Color fishColor = Color(prefs.getInt('fish_color') ?? Colors.orange.value);

    List<Fish> fishList = List.generate(fishCount, (index) => Fish(color: fishColor, speed: fishSpeed));

    return AquariumSettings(fishList: fishList, fishSpeed: fishSpeed, fishColor: fishColor);
  }
}

class AquariumSettings {
  final List<Fish> fishList;
  final double fishSpeed;
  final Color fishColor;

  AquariumSettings({required this.fishList, required this.fishSpeed, required this.fishColor});
}
