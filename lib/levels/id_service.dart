import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class IdService {
  static final IdService instance = IdService._constructor();
  int? _currentId;

  IdService._constructor();

  Future<int> getCurrentId() async {
    if (_currentId == null) {
      String jsonString =
          await rootBundle.loadString('assets/AnagramsMediumLevel.json');
      List<dynamic> jsonData = jsonDecode(jsonString);
      _currentId = Random().nextInt(jsonData.length);
    }
    return _currentId!;
  }

  void resetId() {
    _currentId = null;
  }
}

