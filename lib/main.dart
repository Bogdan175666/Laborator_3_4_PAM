import 'package:flutter/material.dart';
import 'presentation/home_screen.dart';

// Funcția principală care pornește aplicația
void main() {
  runApp(BarberShopApp());
}

// Clasa principală a aplicației
class BarberShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titlul aplicației
      title: 'Barber Shop',

      // Tema aplicației
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Ajustează densitatea vizuală pentru diferite platforme
      ),

      // Ecranul de pornire al aplicației
      home: HomeScreen(),
    );
  }
}
