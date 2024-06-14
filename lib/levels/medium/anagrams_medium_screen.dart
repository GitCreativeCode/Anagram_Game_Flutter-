import 'package:anagrams/levels/medium/anagrams_medium_input.dart';
import 'package:anagrams/levels/medium/anagrams_medium_appbar.dart';
import 'package:anagrams/levels/medium/anagrams_medium_word.dart';
import 'package:anagrams/levels/id_service.dart';
import 'package:flutter/material.dart';

class AnagramsMediumScreen extends StatefulWidget {
  const AnagramsMediumScreen({super.key});

  @override
  State<AnagramsMediumScreen> createState() => _AnagramsMediumScreenState();
}

class _AnagramsMediumScreenState extends State<AnagramsMediumScreen> {
  int? currentId;

  @override
  void initState() {
    super.initState();
    _fetchAndResetId();
  }

  Future<void> _fetchAndResetId() async {
    IdService.instance.resetId();
    int id = await IdService.instance.getCurrentId();
    setState(() {
      currentId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnagramsMediumAppbar(),
      body: currentId == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: AnagramsMediumWord(id: currentId!),
                ),
                Expanded(
                  flex: 2,
                  child: AnagramsMediumInput(id: currentId!),
                ),
              ],
            ),
    );
  }
}
