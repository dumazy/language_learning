import 'package:flutter/material.dart';
import 'package:language_learning/random_words/controller.dart';
import 'package:provider/provider.dart';

class RandomWordsScreen extends StatelessWidget {
  const RandomWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<RandomWordsController>(
      create: (_) => RandomWordsController(),
      dispose: (_, controller) => controller.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Random words'),
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller =
        Provider.of<RandomWordsController>(context, listen: false);
    return StreamBuilder<String>(
      stream: _controller.wordToTranslate,
      builder: (_, snapshot) {
        if (!snapshot.hasData) return const _Loading();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Score(),
            Center(
              child: Text(
                snapshot.requireData,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _AnswerInput(),
          ],
        );
      },
    );
  }
}

class _AnswerInput extends StatefulWidget {
  const _AnswerInput({Key? key}) : super(key: key);

  @override
  State<_AnswerInput> createState() => _AnswerInputState();
}

class _AnswerInputState extends State<_AnswerInput> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SizedBox(
            width: 150,
            child: TextField(
              controller: _inputController,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: _submitAnswer,
          child: const Text('Check'),
        ),
      ],
    );
  }

  void _submitAnswer() {
    final value = _inputController.text;

    final _controller =
        Provider.of<RandomWordsController>(context, listen: false);
    _controller.enterAnswer(value);
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller =
        Provider.of<RandomWordsController>(context, listen: false);
    return StreamBuilder<int>(
      stream: _controller.score,
      initialData: _controller.currentScore,
      builder: (context, snapshot) {
        final score = snapshot.requireData;
        return Center(
          child: Text('Score: $score'),
        );
      },
    );
  }
}
