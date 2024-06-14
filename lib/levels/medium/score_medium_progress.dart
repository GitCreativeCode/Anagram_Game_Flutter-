import 'package:flutter/material.dart';

class ScoreProgress extends StatefulWidget {
  const ScoreProgress({super.key});

  static ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  State<ScoreProgress> createState() => _ScoreProgressState();
}

class _ScoreProgressState extends State<ScoreProgress> {
  @override
  void dispose() {
    ScoreProgress.scoreNotifier.value = 0; // Reset the score
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ScoreProgress.scoreNotifier,
      builder: (context, score, child) {
        return Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            'Score: $score',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
