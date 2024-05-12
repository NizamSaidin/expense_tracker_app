import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/providers/statistic/statistic_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCategoryPieChartWidget extends ConsumerWidget {
  const ExpenseCategoryPieChartWidget({super.key, required this.selectedDate});

  final String selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(expenseCategoryProvider(selectedDate));

    return Card(
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
    );
  }
}
