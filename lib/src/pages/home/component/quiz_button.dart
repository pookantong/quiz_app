import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class QuizButton extends StatelessWidget {
  final Function()? onPressed;
  final String name;
  final int score;
  final bool completed;
  const QuizButton({
    super.key,
    required this.onPressed,
    required this.name,
    required this.score,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final boxColor =
        completed ? Color.fromARGB(255, 53, 122, 56) : HexColor('#44564a');

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
          height: 100,
          width: 275,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Prompt",
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  score.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Prompt",
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
