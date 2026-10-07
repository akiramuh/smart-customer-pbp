class CustomerEvent {
  final String time;
  final int customersInside;
  final String densityStatus;

  const CustomerEvent({
    required this.time,
    required this.customersInside,
    required this.densityStatus,
  });
}

class AnalyticsSummary {
  final String averageVisitors;
  final String busiestHour;
  final String highestDensity;
  final String lowestDensity;

  const AnalyticsSummary({
    required this.averageVisitors,
    required this.busiestHour,
    required this.highestDensity,
    required this.lowestDensity,
  });
}
