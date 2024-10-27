import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TrafficSignalApp());

class TrafficSignalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrafficSignalScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TrafficSignalScreen extends StatefulWidget {
  @override
  _TrafficSignalScreenState createState() => _TrafficSignalScreenState();
}

class _TrafficSignalScreenState extends State<TrafficSignalScreen> {
  Color greenLightColor = Colors.grey;
  Color redLightColor = Colors.red;
  bool isGreenOn = false;
  int timerValue = 100;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerValue > 0) {
          timerValue--;
        } else {
          if (isGreenOn) {
            timerValue = 100;  // Red light timing
            greenLightColor = Colors.grey;
            redLightColor = Colors.red;
          } else {
            timerValue = 25;  // Green light timing
            greenLightColor = Colors.green;
            redLightColor = Colors.grey;
          }
          isGreenOn = !isGreenOn;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/map_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Traffic Signal
          Positioned(
            top: 40,
            left: 2,
            child: Container(
              width: 120,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: redLightColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: redLightColor.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: greenLightColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: greenLightColor.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '  -$timerValue-\n Next\nSignal',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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