import '../models/customer_event.dart';

class ApiService {
  // Dummy/local data for now.
  // Nanti bagian ini bisa diganti dengan HTTP request ke backend.

  Future<List<CustomerEvent>> fetchHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return const [
      CustomerEvent(time: '10:00', customersInside: 28, densityStatus: 'RAMAI'),
      CustomerEvent(time: '09:00', customersInside: 22, densityStatus: 'NORMAL'),
      CustomerEvent(time: '08:00', customersInside: 16, densityStatus: 'NORMAL'),
      CustomerEvent(time: '07:00', customersInside: 12, densityStatus: 'NORMAL'),
      CustomerEvent(time: '06:00', customersInside: 8, densityStatus: 'SEPI'),
    ];
  }

  Future<AnalyticsSummary> fetchAnalyticsSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    return const AnalyticsSummary(
      averageVisitors: '24 orang',
      busiestHour: '10:00 - 11:00',
      highestDensity: '35 orang',
      lowestDensity: '8 orang',
    );
  }
}
