import 'dart:async';
import 'package:anagrams/levels/id_service.dart';
import 'package:anagrams/levels/medium/countdown_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'anagrams_medium_input.dart';
import 'anagrams_medium_appbar.dart';
import 'anagrams_medium_word.dart';
import 'score_medium_progress.dart';

class AnagramsMediumScreen extends StatefulWidget {
  final Function(int) onScoreUpdate;

  const AnagramsMediumScreen({Key? key, required this.onScoreUpdate})
      : super(key: key);

  @override
  State<AnagramsMediumScreen> createState() => _AnagramsMediumScreenState();
}

class _AnagramsMediumScreenState extends State<AnagramsMediumScreen> {
  int? currentId;
  int _score = 0;
  late Timer _timer;
  int _remainingTime = 10;
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _fetchAndResetId();
    _startTimer();
    _loadHighScore();
  }

  Future<void> _fetchAndResetId() async {
    IdService.instance.resetId();
    int id = await IdService.instance.getCurrentId();
    setState(() {
      currentId = id;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _remainingTime--;
            });
          }
        });
      } else {
        _timer.cancel();
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (mounted) {
            widget.onScoreUpdate(_score);
            _showEndDialog();
          }
        });
      }
    });
  }

  void _updateScore(int score) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _score += score;
          ScoreProgress.scoreNotifier.value = _score; // Update score notifier
        });
      }
    });
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _highScore = prefs.getInt('highScore') ?? 0;
        });
      }
    });
  }

  void _updateHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (_score > _highScore) {
      await prefs.setInt('highScore', _score);
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _highScore = _score;
          });
        }
      });
    }
  }

  void _showEndDialog() {
    _updateHighScore();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Text('Your Score: $_score\nHigh Score: $_highScore'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Restart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountdownScreen(),  // Navigate to CountdownScreen
                      ),
                    );
                  },
                ),
                TextButton(
                  child: const Text('Go Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnagramsMediumAppbar(),
      body: currentId == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        const ScoreProgress(),
                        Text('Time: $_remainingTime',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AnagramsMediumWord(id: currentId!),
                ),
                Expanded(
                  flex: 2,
                  child: AnagramsMediumInput(
                    id: currentId!,
                    onWordSubmitted: _updateScore,
                  ),
                ),
              ],
            ),
    );
  }
}
