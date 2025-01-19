import 'dart:async';

import 'package:flutter/material.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  late int seconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    seconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      ++seconds;
    });
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            '$seconds ${_secondsText()}',
            style: const TextStyle(fontSize: 35),
          ),
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
