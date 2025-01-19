import 'dart:async';

import 'package:flutter/material.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  late int seconds = 0;
  late Timer timer;
  bool isTicking = false;

  void _onTick(Timer timer) {
    setState(() {
      ++seconds;
    });
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  void _starTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);

    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              '$seconds ${_secondsText()}',
              style: const TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: isTicking ? null : _starTimer,
                  style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(100, 100)),
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Start'),
                ),
                TextButton(
                  onPressed: isTicking ? _stopTimer : null,
                  style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(100, 100)),
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Stop'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
