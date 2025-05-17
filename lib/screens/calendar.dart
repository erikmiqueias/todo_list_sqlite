import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstDate = DateTime(2025, 5, 11);
    final lastDate = firstDate.add(const Duration(days: 365));

    final initialDate = _now.isBefore(firstDate) ? firstDate : _now;

    return Scaffold(
      body: SafeArea(
        child: CalendarDatePicker(
          initialCalendarMode: DatePickerMode.day,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onDateChanged: (date) {},
        ),
      ),
    );
  }
}
