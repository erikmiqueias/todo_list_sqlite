import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_sqlite/providers/date_provider.dart';

class CalendarScreen extends ConsumerWidget {
  CalendarScreen({super.key});
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onDateChanged: (date) {
            ref.read(dateProvider.notifier).changeNewDate(date.toString());
          },
        ),
      ),
    );
  }
}
