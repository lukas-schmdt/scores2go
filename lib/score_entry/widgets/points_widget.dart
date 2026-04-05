import 'package:flutter/material.dart';

class PointsCircle extends StatelessWidget {
  const PointsCircle({super.key, required this.value});

  final num value;

  String get displayValue {
    if (value > 0) return '+$value';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      child: Text(displayValue, style: const TextStyle(fontSize: 11)),
    );
  }
}
