import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stock_learner/core/models/profile/stock_chart.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<StockChart> chart;
  final Color color;

  const SimpleTimeSeriesChart({
    super.key,
    required this.chart,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: chart
                .map((item) => FlSpot(
                    DateTime.parse(item.date).millisecondsSinceEpoch.toDouble(),
                    item.close))
                .toList(),
            color: color,
            barWidth: 2,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
