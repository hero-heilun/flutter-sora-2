import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for accent color manager
final accentColorManagerProvider = ChangeNotifierProvider<AccentColorManager>((ref) {
  return AccentColorManager();
});

class AccentColorManager extends ChangeNotifier {
  static const String _accentColorKey = 'accent_color';
  static const String _ambientColorKey = 'ambient_color';
  
  Color _currentAccentColor = Colors.blue;
  Color _ambientColor = Colors.black;
  SharedPreferences? _prefs;
  
  Color get currentAccentColor => _currentAccentColor;
  Color get ambientColor => _ambientColor;
  
  AccentColorManager() {
    _loadColors();
  }

  Future<void> _loadColors() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load accent color
    final accentColorValue = _prefs?.getInt(_accentColorKey);
    if (accentColorValue != null) {
      _currentAccentColor = Color(accentColorValue);
    }
    
    // Load ambient color
    final ambientColorValue = _prefs?.getInt(_ambientColorKey);
    if (ambientColorValue != null) {
      _ambientColor = Color(ambientColorValue);
    }
    
    notifyListeners();
  }

  Future<void> setAccentColor(Color color) async {
    _currentAccentColor = color;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_accentColorKey, color.value);
    notifyListeners();
  }

  Future<void> setAmbientColor(Color color) async {
    _ambientColor = color;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_ambientColorKey, color.value);
    notifyListeners();
  }

  // Reset to default colors
  Future<void> resetColors() async {
    _currentAccentColor = Colors.blue;
    _ambientColor = Colors.black;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(_accentColorKey);
    await _prefs!.remove(_ambientColorKey);
    notifyListeners();
  }

  // Predefined accent colors
  static const List<Color> predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
  ];

  // Generate ambient color from dominant color
  Color generateAmbientColor(Color dominantColor) {
    // Create a darker, more muted version for ambient background
    final hsl = HSLColor.fromColor(dominantColor);
    return hsl.withLightness((hsl.lightness * 0.3).clamp(0.0, 1.0))
              .withSaturation((hsl.saturation * 0.6).clamp(0.0, 1.0))
              .toColor();
  }
}