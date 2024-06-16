import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'anagrams_medium_screen.dart';
import 'anagrams_medium_appbar.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  bool _showCountdown = false;
  String _countdownText = '';
  int _currentScore = 0;
  int _highScore = 0;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (!_isDisposed) {
      setState(() {
        _highScore = prefs.getInt('highScore') ?? 0;
      });
    }
  }

  void _startGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AnagramsMediumScreen(
          onScoreUpdate: (score) {
            if (!_isDisposed) {
              setState(() {
                _currentScore = score;
              });
              _updateHighScore();
            }
          },
          //onTimeUp: _showEndDialog,
        ),
      ),
    );
  }

  void _updateHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentScore > _highScore) {
      await prefs.setInt('highScore', _currentScore);
      if (!_isDisposed) {
        setState(() {
          _highScore = _currentScore;
        });
      }
    }
  }

  // void _showEndDialog() {
  //   print("Time's up! Showing end dialog."); // Debug statement
  //   if (!_isDisposed) {
  //     WidgetsBinding.instance?.addPostFrameCallback((_) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Game Over'),
  //             content:
  //                 Text('Your Score: $_currentScore\nHigh Score: $_highScore'),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('Restart'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => CountdownScreen(),
  //                     ),
  //                   );
  //                 },
  //               ),
  //               TextButton(
  //                 child: Text('Go Back'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     });
  //   }
  // }

  void _startCountdown() {
    setState(() {
      _showCountdown = true;
      _countdownText = 'Ready?';
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!_isDisposed) {
        setState(() {
          _countdownText = 'Get Set';
        });
        Future.delayed(const Duration(seconds: 1), () {
          if (!_isDisposed) {
            setState(() {
              _countdownText = 'GO!';
            });
            Future.delayed(const Duration(seconds: 1), () {
              if (!_isDisposed) {
                _startGame();
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnagramsMediumAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'High Score: $_highScore',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startCountdown,
              child: const Text('Start'),
            ),
            if (_showCountdown)
              Text(
                _countdownText,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
