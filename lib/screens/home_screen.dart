import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;

  int totalSecond = twentyFiveMinutes; //25분
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;

  onTick(Timer timer) {
    if (totalSecond == 0) {
      setState(() {
        //running end
        totalPomodoros = totalPomodoros + 1;
        totalSecond = twentyFiveMinutes;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  onStartPressd() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  onResetPressed() {
    setState(() {
      totalSecond = twentyFiveMinutes;
      isRunning = false;
    });
    timer.cancel();
  }

  onNextPressed() {
    setState(() {
      totalSecond = twentyFiveMinutes;
      totalPomodoros = totalPomodoros + 1;
      isRunning = false;
    });
    timer.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var min = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    var sec = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecond),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    icon: const Icon(Icons.stop),
                    onPressed: onResetPressed,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                    onPressed: isRunning ? onPausePressed : onStartPressd,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    icon: const Icon(Icons.skip_next),
                    onPressed: onNextPressed,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pomodoros',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                  Text(
                    '$totalPomodoros',
                    style: TextStyle(
                      fontSize: 58,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
