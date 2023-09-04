import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
          height: 55,
          width: 275,
          decoration: BoxDecoration(
            color: HexColor('#44564a'),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Prompt",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
