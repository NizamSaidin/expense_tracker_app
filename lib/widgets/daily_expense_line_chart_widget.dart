import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/providers/statistic/statistic_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DailyExpenseLineChartWidget extends ConsumerWidget {
  const DailyExpenseLineChartWidget({Key? key, required this.selectedDate}) : super(key: key);

  final String selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(settingProvider).requireValue;
    final expensesByDay = ref.watch(expensesByDayProvider(selectedDate));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'Total Daily Expenses',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            expensesByDay.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text('Unable to load data. Please try again later.')),
              data: (List<Expense> values) {
                final totalAmount = values.fold<double>(0, (previousValue, element) => (previousValue + (element.amount ?? 0)));
                return SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: false,
                        drawVerticalLine: false,
                        drawHorizontalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return const FlLine(
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          axisNameWidget: const Text(
                            'Day',
                            style: TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          axisNameSize: 25,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 31,
                            interval: 7,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              int day = value.toInt();
                              if (day == 0) {
                                day = 1;
                              }
                              if (day > 30) {
                                return const SizedBox();
                              }
                              return Text(DateFormat('dd/MM').format(DateTime(DateTime.now().year, DateTime.now().month, day)));
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          axisNameWidget: Text(
                            'Total Amount (${setting.currency})',
                            style: const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          sideTitles: const SideTitles(
                            showTitles: true,
                            interval: 500,
                            reservedSize: 35,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(
                            color: Color(0xff7589a2),
                            width: 1,
                          ),
                          left: BorderSide(
                            color: Color(0xff7589a2),
                            width: 1,
                          ),
                          right: BorderSide(
                            color: Colors.transparent,
                          ),
                          top: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      minX: 0,
                      maxX: 31,
                      minY: 0,
                      maxY: totalAmount,
                      lineBarsData: [
                        LineChartBarData(
                          spots: values.map(
                            (expense) {
                              return FlSpot(expense.dateTime.day.toDouble(), expense.amount ?? 0);
                            },
                          ).toList(),
                          isCurved: false,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
