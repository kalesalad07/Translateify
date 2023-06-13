import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translateify/utils/globals.dart';

class LanguageService extends ChangeNotifier {
  Future<List> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/languages.json');
    final Map map = jsonDecode(response);
    return map['data']['languages'];
  }

  void languageList() async {
    List map = await readJsonFile();
    for (final item in map) {
      languages.add(item['language']);
    }
    print(languages);
  }
}
