import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  const ChartBar({required this.label, required this.value, required this.percentage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(value.toStringAsFixed(2))),
        const SizedBox(height: 5),
        RotatedBox(
          quarterTurns: -1,
          child: SizedBox(
            height: 10,
            width: 60,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: const Color.fromRGBO(210, 210, 210, 1),
              borderRadius: BorderRadius.circular(5),
              
            ),
          ),
        ),
        Text(label),
      ],
    );
  }
}
