import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer? timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 199, 220, 234),
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Center(
              child: Text('Timer'),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelText(
                        label: 'HRS', value: hours.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'MIN',
                        value: minutes.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'SEC',
                        value: seconds.toString().padLeft(2, '0')),
                  ],
                ),
                const SizedBox(height: 60),
                Container(
                  width: 200,
                  height: 47,
                  margin: const EdgeInsets.only(top: 30),
                  child: TextButton(
                    child: Text(
                      isActive ? 'STOP' : 'START',
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 30),
                    ),
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class LabelText extends StatelessWidget {
  LabelText({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.blueGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
