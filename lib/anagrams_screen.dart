import 'package:flutter/material.dart';
import 'package:anagrams/levels/anagrams_levels.dart';

class AnagramsScreen extends StatefulWidget {
  const AnagramsScreen({super.key});

  @override
  State<AnagramsScreen> createState() => _AnagramsScreenState();
}

class _AnagramsScreenState extends State<AnagramsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anagrams"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: AnagramsLevels(),
      ),
    );
  }
}
