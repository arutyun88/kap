import 'package:get/get.dart';

class LaunchTrackerService extends GetxService {
  static void init() => Get.lazyPut(() => LaunchTrackerService());

  static LaunchTrackerService get to => Get.find<LaunchTrackerService>();

  final Map<String, DateTime> _startTimes = {};
  final Map<String, DateTime> _endTimes = {};

  void startService(String serviceName) => _startTimes[serviceName] = DateTime.now();

  void stopService(String serviceName) => _endTimes[serviceName] = DateTime.now();

  Duration? getServiceDuration(String serviceName) {
    final startTime = _startTimes[serviceName];
    final endTime = _endTimes[serviceName];
    if (startTime == null || endTime == null) return null;
    return endTime.difference(startTime);
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('Launch Tracker Service:');
    _startTimes.forEach(
      (serviceName, startTime) {
        final endTime = _endTimes[serviceName];
        final duration = endTime?.difference(startTime);
        buffer.writeln('$serviceName (Duration: $duration)');
      },
    );
    return buffer.toString();
  }
}
