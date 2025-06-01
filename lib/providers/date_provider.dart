import 'package:flutter_riverpod/flutter_riverpod.dart';

final now = DateTime.now();

class DateNotifier extends StateNotifier<String> {
  DateNotifier() : super(now.toString());

  void changeNewDate(String newDate) {
    state = newDate;
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, String>(
  (ref) => DateNotifier(),
);

final getDateProvider = Provider<String>((ref) => ref.watch(dateProvider));
