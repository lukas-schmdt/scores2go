import 'dart:async';
import 'package:flutter/material.dart';

class CalculatorLoading extends StatefulWidget {
  const CalculatorLoading({super.key});

  @override
  State<CalculatorLoading> createState() => _CalculatorLoadingState();
}

class _CalculatorLoadingState extends State<CalculatorLoading> {
  String display = "";
  final List<String> sequence = ["1+1", "42", "√16", "3.14", "..."];

  int index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      setState(() {
        index = (index + 1) % sequence.length;
        display = sequence[index];
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            display,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 28,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}
