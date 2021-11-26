import 'dart:async';

import 'package:language_learning/random_words/model.dart';
import 'package:language_learning/random_words/repository.dart';

class RandomWordsController {
  final RandomWordsRepository _repository;

  final _controller = StreamController<Translation>.broadcast();
  late Translation _currentTranslation;
  int _currentIndex = 0;

  final _scoreController = StreamController<int>.broadcast();
  int _points = 0;
  int get currentScore => _points;
  Stream<int> get score => _scoreController.stream;

  late List<Translation> _translations;

  RandomWordsController([RandomWordsRepository? repository])
      : _repository = repository ?? const RandomWordsRepositoryImpl() {
    _init();
  }

  Stream<String> get wordToTranslate =>
      _controller.stream.map((translation) => translation.origin);

  Future<void> _init() async {
    _translations = await _repository.getTranslations();

    _moveToIndex(0);
  }

  void _moveToIndex(int index) {
    _currentIndex = index;
    _currentTranslation = _translations[_currentIndex];
    _controller.add(_currentTranslation);
  }

  Future<bool> enterAnswer(String answer) async {
    bool correct = false;
    if (answer == _currentTranslation.translated) {
      correct = true;
      _addPoint();
    }
    _moveToIndex(++_currentIndex);
    return correct;
  }

  void _addPoint() {
    _points++;
    _scoreController.add(_points);
  }

  void dispose() {
    _scoreController.close();
    _controller.close();
  }
}
