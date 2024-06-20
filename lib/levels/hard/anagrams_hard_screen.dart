import 'package:flutter/material.dart';
import 'anagrams_hard_appbar.dart';

class AnagramsHardScreen extends StatefulWidget {
  const AnagramsHardScreen({super.key});

  @override
  State<AnagramsHardScreen> createState() => _AnagramsHardScreenState();
}

class _AnagramsHardScreenState extends State<AnagramsHardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnagramsHardAppbar(),
      body: Text('Did i not say to open this? >('),
    );
  }
}