import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'score_medium_progress.dart';

class AnagramsMediumInput extends StatefulWidget {
  final int id;
  const AnagramsMediumInput({Key? key, required this.id}) : super(key: key);

  @override
  State<AnagramsMediumInput> createState() => _AnagramsMediumInputState();
}

class _AnagramsMediumInputState extends State<AnagramsMediumInput> {
  final TextEditingController _controller = TextEditingController();
  String _message = '';
  List<String> _solution = [];
  Set<String> _correctAnswers = {};

  @override
  void initState() {
    super.initState();
    _loadSolution();
  }

  Future<void> _loadSolution() async {
    String jsonString =
        await rootBundle.loadString('assets/AnagramsMediumLevel.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      _solution = List<String>.from(jsonData[widget.id]['solution']);
    });
  }

  void _checkSolution() {
    String userAnswer = _controller.text.toLowerCase();

    if (userAnswer.isEmpty || !_solution.contains(userAnswer)) {
      setState(() {
        _message = 'Wrong word/invalid word';
      });
    } else if (_correctAnswers.contains(userAnswer)) {
      setState(() {
        _message = 'You already got this word!';
      });
    } else {
      setState(() {
        _message = 'Correct solution!';
        _correctAnswers.add(userAnswer);
        _updateScore(userAnswer);
        _controller.clear();
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _message = '';
        });
      });
    }
  }

  void _updateScore(String word) {
    int newScore = word.length * 25;
    ScoreProgress.scoreNotifier.value += newScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter A Word',
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
          Text(_message),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _checkSolution,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
