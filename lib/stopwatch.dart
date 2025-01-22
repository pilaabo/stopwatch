import 'dart:async';

import 'package:flutter/material.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  late int milliseconds = 0;
  late Timer timer;
  bool isTicking = false;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    scrollController.animateTo(
      itemHeight * laps.length,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  void _starTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);

    setState(() {
      laps.clear();
      milliseconds = 0;
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
          children: [
            Expanded(child: _buildCounter(context)),
            Expanded(child: _buildLapDisplay())
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Text(
          'Lap ${laps.length + 1}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          _secondsText(milliseconds),
          style: const TextStyle(fontSize: 35),
        ),
        _buildControls()
      ],
    );
  }

  Widget _buildControls() {
    return Row(
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
          child: const Text('Start', style: TextStyle(fontSize: 20)),
        ),
        ElevatedButton(
          onPressed: isTicking ? _lap : null,
          style: const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(100, 100)),
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          child: const Text('Lap', style: TextStyle(fontSize: 20)),
        ),
        ElevatedButton(
          onPressed: isTicking ? _stopTimer : null,
          style: const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(100, 100)),
            backgroundColor: WidgetStatePropertyAll(Colors.red),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          child: const Text('Stop', style: TextStyle(fontSize: 20)),
        )
      ],
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
            title: Text(
              'Lap ${index + 1}',
              style: const TextStyle(fontSize: 20),
            ),
            trailing: Text(
              _secondsText(milliseconds),
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
