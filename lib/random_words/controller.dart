import 'dart:async';

import 'package:language_learning/random_words/model.dart';
import 'package:language_learning/random_words/repository.dart';

class RandomWordsController {
  final RandomWordsRepository _repository;

  final _controller = StreamController<Translation>();
  late Translation _currentTranslation;
  int _currentIndex = 0;

  final _scoreController = StreamController<int>();
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

  Future<void> enterAnswer(String answer) async {
    if (answer == _currentTranslation.translated) {
      print('correct answer');
      _addPoint();
    } else {
      print('wrong answer');
    }
    _moveToIndex(++_currentIndex);
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
