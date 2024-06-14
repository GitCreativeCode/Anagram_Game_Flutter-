import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnagramsMediumWord extends StatefulWidget {
  final int id;
  const AnagramsMediumWord({Key? key, required this.id}) : super(key: key);

  @override
  _AnagramsMediumWordState createState() => _AnagramsMediumWordState();
}

class _AnagramsMediumWordState extends State<AnagramsMediumWord> {
  String _scrambledLetters = '';

  @override
  void initState() {
    super.initState();
    _loadScrambledLetters();
  }

  Future<void> _loadScrambledLetters() async {
    String jsonString =
        await rootBundle.loadString('assets/AnagramsMediumLevel.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      _scrambledLetters = jsonData[widget.id]['scrambled_letters'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _scrambledLetters,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
