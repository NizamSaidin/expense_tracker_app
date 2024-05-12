import 'package:expense_tracker_app/utils/constants.dart';
import 'package:expense_tracker_app/widgets/daily_expense_line_chart_widget.dart';
import 'package:expense_tracker_app/widgets/expense_category_pie_chart_widget.dart';
import 'package:expense_tracker_app/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  DateTime selectedDate = DateTime.now();

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate);

  @override
  Widget build(BuildContext context) {
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
                      });
                    }
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [Text(DateFormat('MMMM yyyy').format(selectedDate))]),
                ),
              ),
              const SizedBox(height: 20),
              ExpenseCategoryPieChartWidget(selectedDate: formattedDate),
              const SizedBox(height: 20),
              DailyExpenseLineChartWidget(selectedDate: formattedDate),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
