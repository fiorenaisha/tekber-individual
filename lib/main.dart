import 'package:flutter/material.dart';
import 'profilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Personal Profile',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFBFAF6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B7FFF)),
      ),
      // Landing page langsung menampilkan profil (1 screen).
      home: const ProfileScreen(),
    );
  }
}