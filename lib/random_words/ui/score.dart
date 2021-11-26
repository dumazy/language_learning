import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller.dart';

const scoreWidth = 350.0;
const scoreHeight = 140.0;

class Score extends StatelessWidget {
  const Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller =
        Provider.of<RandomWordsController>(context, listen: false);
    return StreamBuilder<int>(
      stream: _controller.score,
      initialData: _controller.currentScore,
      builder: (context, snapshot) {
        final score = snapshot.requireData;
        return ClipPath(
          clipper: _ScoreClipper(),
          child: Container(
            color: Colors.teal,
            child: SizedBox(
              width: scoreWidth,
              height: scoreHeight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Text(
                          'Score',
                          style: GoogleFonts.ubuntu(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '$score',
                          style: GoogleFonts.ubuntu(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScoreClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.cubicTo(width / 2, 0, width / 2, height, width, height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
