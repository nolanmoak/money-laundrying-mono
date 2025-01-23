import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentTime extends StatefulWidget {
  const CurrentTime({super.key});

  @override
  State<CurrentTime> createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  String currentTimeText = '';

  void _onPeriodicUpdate() {
    final dateTime = DateTime.now();
    setState(() {
      currentTimeText = DateFormat('EEEE, MMM. dd, h:mm:ss a').format(dateTime);
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(
        milliseconds: 100,
      ),
      (_) => _onPeriodicUpdate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTimeText,
      style: const TextStyle(fontSize: 40),
    );
  }
}
