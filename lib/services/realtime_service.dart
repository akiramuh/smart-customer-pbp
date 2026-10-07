import 'dart:async';

import '../models/customer_stats.dart';

class RealtimeService {
  RealtimeService({Duration interval = const Duration(seconds: 3)})
      : _interval = interval;

  final Duration _interval;

  Stream<CustomerStats> watchStats() async* {
    var stats = const CustomerStats(
      currentVisitors: 28,
      totalEntry: 35,
      totalExit: 7,
    );

    yield stats;

    await for (final _ in Stream.periodic(_interval)) {
      final nextVisitors = stats.currentVisitors >= 40
          ? 20
          : stats.currentVisitors + 1;

      stats = stats.copyWith(
        currentVisitors: nextVisitors,
        totalEntry: stats.totalEntry + 1,
      );

      yield stats;
    }
  }
}
