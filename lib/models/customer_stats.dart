import 'package:flutter/material.dart';

class CustomerStats {
  final int currentVisitors;
  final int totalEntry;
  final int totalExit;
  final int maxCapacity;
  final bool sensorOnline;

  const CustomerStats({
    required this.currentVisitors,
    required this.totalEntry,
    required this.totalExit,
    this.maxCapacity = 40,
    this.sensorOnline = true,
  });

  String get densityStatus {
    if (currentVisitors <= 10) return 'SEPI';
    if (currentVisitors <= 25) return 'NORMAL';
    if (currentVisitors <= 35) return 'RAMAI';
    return 'SANGAT RAMAI';
  }

  Color get densityColor {
    switch (densityStatus) {
      case 'SEPI':
        return Colors.green;
      case 'NORMAL':
        return Colors.blue;
      case 'RAMAI':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  double get capacityPercentage {
    if (maxCapacity <= 0) return 0;
    return (currentVisitors / maxCapacity).clamp(0.0, 1.0);
  }

  CustomerStats copyWith({
    int? currentVisitors,
    int? totalEntry,
    int? totalExit,
    int? maxCapacity,
    bool? sensorOnline,
  }) {
    return CustomerStats(
      currentVisitors: currentVisitors ?? this.currentVisitors,
      totalEntry: totalEntry ?? this.totalEntry,
      totalExit: totalExit ?? this.totalExit,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      sensorOnline: sensorOnline ?? this.sensorOnline,
    );
  }
}
