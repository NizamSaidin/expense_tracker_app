import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/providers/statistic/statistic_provider.dart';
import 'package:expense_tracker_app/utils/constants.dart';
import 'package:expense_tracker_app/widgets/title_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StatisticView extends ConsumerStatefulWidget {
  const StatisticView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StatisticViewState();
}

class StatisticViewState extends ConsumerState<StatisticView> {
  DateTime selectedDate = DateTime.now();

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate);

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(expenseCategoryProvider(formattedDate));
    final setting = ref.watch(settingProvider).requireValue;
    final expensesByDay = ref.watch(expensesByDayProvider(formattedDate));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleWidget(title: 'Statistic'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    var result = await Navigator.of(context).pushNamed(Constants.dateFilterRoute, arguments: {
                      'selectedYear': selectedDate.year,
                      'selectedMonth': selectedDate.month,
                    });

                    if (result != null && result is DateTime) {
                      setState(() {
                        selectedDate = result;
                        ref.refresh(expenseCategoryProvider(formattedDate).future);
                        ref.refresh(expensesByDayProvider(formattedDate).future);
                      });
                    }
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [Text(DateFormat('MMMM yyyy').format(selectedDate))]),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Expenses by Category',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),
                      categories.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => const Center(child: Text('Unable to load data. Please try again later.')),
                        data: (List<Category> values) {
                          final totalAmount = values.fold<double>(0, (previousValue, element) => (previousValue + (element.totalAmount ?? 0)));
                          if (totalAmount < 1) {
                            return SizedBox(
                              height: 150,
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.pie_chart, size: 100, color: Theme.of(context).colorScheme.secondary),
                                    const SizedBox(height: 10),
                                    Text(
                                      'No data available',
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: PieChart(
                              PieChartData(
                                sections: values.map((category) {
                                  double percentage = (category.totalAmount ?? 0) / totalAmount * 100;
                                  if (!percentage.isFinite) {
                                    percentage = 0;
                                  }
                                  return PieChartSectionData(
                                    color: category.color,
                                    value: percentage,
                                    title: '${percentage.round()} %',
                                    badgePositionPercentageOffset: 0.8,
                                    badgeWidget: Text(category.name),
                                    radius: 60,
                                    titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  );
                                }).toList(),
                              ),
                              swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                              swapAnimationCurve: Curves.linear, // Optional
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
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
                                      reservedSize: 40,
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
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
