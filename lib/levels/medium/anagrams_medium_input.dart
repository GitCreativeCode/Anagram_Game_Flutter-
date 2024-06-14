import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    if (_controller.text.isEmpty ||
        !_solution.contains(_controller.text.toLowerCase())) {
      setState(() {
        _message = 'Wrong word/invalid word';
      });
    } else {
      setState(() {
        _message = 'Correct solution!';
        _controller.clear();
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _message = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
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
