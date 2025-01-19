import 'package:flutter/material.dart';
import 'stopwatch.dart' as stopwatch;

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: stopwatch.Stopwatch(),
    );
  }
}
