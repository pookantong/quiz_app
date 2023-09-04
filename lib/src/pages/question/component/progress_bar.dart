import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int progress;
  const ProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF3F4768), width: 3),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth * progress / 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 88, 194, 97),
                    Color.fromARGB(255, 220, 133, 46)
                  ]),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(
                  progress.toDouble(),
                ),
              ),
            ),
          ],
        ));
  }
}
