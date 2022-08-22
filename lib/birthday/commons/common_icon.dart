import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  const CommonIcon({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.circleSize,
  });

  final String icon;
  final double iconSize;
  final double circleSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: pink,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
      ),
      child: Center(
        child: Text(
          icon,
          style: TextStyle(
            fontSize: iconSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
