import 'package:flutter/material.dart';

class AppColors {
  // Palette "Warm & Safe"
  static const Color primary = Color(0xFFD4A373); // Terre cuite douce
  static const Color secondary = Color(0xFFCCD5AE); // Vert sauge
  static const Color accent = Color(0xFFE9EDC6); // Jaune pale
  
  static const Color background = Color(0xFFFEFAE0); // Crème chaleureuse
  static const Color surface = Colors.white;
  
  static const Color textPrimary = Color(0xFF606C38); // Vert forêt sombre
  static const Color textSecondary = Color(0xFF283618); // Vert très sombre
  
  static const Color error = Color(0xFFBC6C25); // Orange brûlé pour les erreurs (pas trop agressif)
  static const Color success = Color(0xFF80B918);
  
  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFD4A373), Color(0xFFE9EDC6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
