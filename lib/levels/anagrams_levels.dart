import 'package:anagrams/levels/easy/anagrams_easy_screen.dart';
import 'package:anagrams/levels/hard/anagrams_hard_screen.dart';
import 'package:anagrams/levels/medium/anagrams_medium_screen.dart';
import 'package:anagrams/levels/medium/countdown_screen.dart';
import 'package:flutter/material.dart';

class AnagramsLevels extends StatefulWidget {
  const AnagramsLevels({super.key});

  @override
  State<AnagramsLevels> createState() => _AnagramsLevelsState();
}

class _AnagramsLevelsState extends State<AnagramsLevels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Welcome to Anagrams',
            style: TextStyle(fontSize: 30),
          ),
          const Text(
            'Select difficulty level:',
            style: TextStyle(fontSize: 20),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AnagramsEasyLevel()));
                  },
                  child: const Text('Easy'),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => AnagramsMediumScreen(
                //               onScoreUpdate: (score) {
                //                 // Handle score update if needed
                //               },
                //             )));
                //   },
                //   child: const Text('Medium'),
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CountdownScreen()));
                  },
                  child: const Text('Medium'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AnagramsHardScreen()));
                  },
                  child: const Text('Hard'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
