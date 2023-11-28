import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  const ChartBar({required this.label, required this.value, required this.percentage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(value.toStringAsFixed(2))),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            RotatedBox(
              quarterTurns: -1,
              child: SizedBox(
                height: 10,
                width: constraints.maxHeight * 0.7,
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: const Color.fromRGBO(210, 210, 210, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(height: constraints.maxHeight * 0.1, child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
