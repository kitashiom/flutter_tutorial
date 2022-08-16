import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    super.key,
    required this.text,
    required this.textSize,
  });

  final String text;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
