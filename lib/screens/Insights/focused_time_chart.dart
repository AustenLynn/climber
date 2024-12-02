import 'dart:core';

import 'package:climber/Dao/database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../Dao/session.dart';


class FocusedTimeChart extends StatefulWidget {
  final AppDatabase database;
  final int selectedIndex;


  const FocusedTimeChart({super.key, required this.selectedIndex, required this.database});

  @override
  State<FocusedTimeChart> createState() => _FocusedTimeChartState();
}

class _FocusedTimeChartState extends State<FocusedTimeChart> {

  List<BarChartGroupData> _barGroups = [];

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }
  @override
  void didUpdateWidget(covariant FocusedTimeChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _loadChartData();
    }
  }
  Future<List<Session>> getSessionsForToday(AppDatabase database) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59).millisecondsSinceEpoch;
    return database.sessionDao.findSessionsInRange(startOfDay, endOfDay);
  }

  Future<List<Session>> getSessionsForWeek(AppDatabase database) async {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1)); // Monday
    final endOfWeek = startOfWeek.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    final startOfWeekMillis = startOfWeek.millisecondsSinceEpoch;
    final endOfWeekMillis = endOfWeek.millisecondsSinceEpoch;
    return database.sessionDao.findSessionsInRange(startOfWeekMillis, endOfWeekMillis);
  }

  Future<List<Session>> getSessionsForMonth(AppDatabase database) async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(milliseconds: 1)); // Last day of the month
    final startOfMonthMillis = startOfMonth.millisecondsSinceEpoch;
    final endOfMonthMillis = endOfMonth.millisecondsSinceEpoch;
    return database.sessionDao.findSessionsInRange(startOfMonthMillis, endOfMonthMillis);
  }

  Future<List<Session>> getSessionsForYear(AppDatabase database) async {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year + 1, 1, 1).subtract(const Duration(milliseconds: 1)); // Dec 31, 23:59:59
    final startOfYearMillis = startOfYear.millisecondsSinceEpoch;
    final endOfYearMillis = endOfYear.millisecondsSinceEpoch;
    return database.sessionDao.findSessionsInRange(startOfYearMillis, endOfYearMillis);
  }


  Future<void> _loadChartData() async {
    Map<int, Function> periodForChart = {
      0: getSessionsForToday,
      1: getSessionsForWeek,
      2: getSessionsForMonth,
      3: getSessionsForYear,
    };
    final sessionList = await periodForChart[widget.selectedIndex]!(widget.database);
    final chartData = _formatSessionsData(sessionList);
    setState(() {
      _barGroups = chartData;
    });
  }

  List<BarChartGroupData> _formatSessionsData(List<Session> sessionList) {
    debugPrint('Sessions found:');
    for (final session in sessionList) {
      debugPrint(
          'Session ID: ${session.id}, Duration: ${session.minutes}, Time: ${session.dateTimeMillis}');
    }

    int groupCount = 24;
    switch (widget.selectedIndex) {
      case 1:
        groupCount = 7;
        break;
      case 2:
        groupCount = 30;
        break;
      case 3:
        groupCount = 12;
        break;
    }

    final Map<int, double> durations = {for (var i = 0; i < groupCount; i++) i: 0.0};

    for (final session in sessionList) {
      final sessionDate = DateTime.fromMillisecondsSinceEpoch(session.dateTimeMillis);
      int groupIndex;

      if (widget.selectedIndex == 0) {
        // Group by hour (0-23)
        groupIndex = sessionDate.hour;
      } else if (widget.selectedIndex == 1) {
        // Group by day of the week (0-6, Monday is 0)
        groupIndex = sessionDate.weekday - 1; // Convert to 0-based index
      } else if (widget.selectedIndex == 2) {
        // Group by day of the month (1-30)
        groupIndex = sessionDate.day - 1; // Convert to 0-based index
      } else {
        // Group by month (0-11)
        groupIndex = sessionDate.month - 1; // Convert to 0-based index
      }

      durations[groupIndex] = (durations[groupIndex] ?? 0) + session.minutes;
    }

    // Create BarChartGroupData from the durations
    return durations.entries.map((entry) {
      final index = entry.key;
      final durationInMinutes = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: durationInMinutes,
            color: Colors.blue,
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: BarChart(
          BarChartData(
            barGroups: _barGroups,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: _buildBottomAxisTitles(widget.selectedIndex),
            ),
          ),
        ),
      ),
    );
  }

  AxisTitles _buildBottomAxisTitles(int selectedIndex) {
    return AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (selectedIndex == 3 || selectedIndex == 1) return Text('${value.toInt() + 1}');
                    if (value % 6 != 0 ) {return const SizedBox.shrink();}
                    if (selectedIndex == 0 ){
                      return Text(
                        '${value.toInt()}:00',
                      );
                    }
                    if (selectedIndex == 2){
                      return Text(
                        '${value.toInt()}',
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
  }
}




