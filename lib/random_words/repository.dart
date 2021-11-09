import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:language_learning/random_words/model.dart';

abstract class RandomWordsRepository {
  Future<List<Translation>> getTranslations();
}

class RandomWordsRepositoryImpl implements RandomWordsRepository {
  const RandomWordsRepositoryImpl();

  @override
  Future<List<Translation>> getTranslations() async {
    final source = await rootBundle.loadString('assets/translations.json');
    final json = jsonDecode(source);

    return List<Map<String, dynamic>>.from(json).map((item) {
      return Translation(
        origin: item['origin'],
        translated: item['translated'],
      );
    }).toList();
  }
}
