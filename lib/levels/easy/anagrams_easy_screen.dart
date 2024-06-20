import 'package:flutter/material.dart';
import 'anagrams_easy_appbar.dart';

class AnagramsEasyLevel extends StatefulWidget {
  const AnagramsEasyLevel({super.key});

  @override
  State<AnagramsEasyLevel> createState() => _AnagramsEasyLevelState();
}

class _AnagramsEasyLevelState extends State<AnagramsEasyLevel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnagramsEasyAppbar(),
      body: Text('Did i not say to open this? >('),
    );
  }
}