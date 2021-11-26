import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_learning/random_words/controller.dart';
import 'package:provider/provider.dart';

import 'score.dart';

class RandomWordsScreen extends StatelessWidget {
  const RandomWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<RandomWordsController>(
      create: (_) => RandomWordsController(),
      dispose: (_, controller) => controller.dispose(),
      child: const Scaffold(
        body: _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(),
        Expanded(
          child: Center(
            child: _Body(),
          ),
        ),
        SizedBox(
          height: 120,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Align(
          alignment: Alignment.centerRight,
          child: Score(),
        ),
        SizedBox(
          height: 12,
        ),
        _Title(),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Text(
        'Translate the following words:',
        style: GoogleFonts.ubuntu(
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

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
        });
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
