import 'package:expense_tracker_app/widgets/balance_card_widget.dart';
import 'package:expense_tracker_app/widgets/expense_list_widget.dart';
import 'package:expense_tracker_app/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleWidget(title: 'Expense Tracker', showSettingIcon: true),
            BalanceCardWidget(),
            SizedBox(height: 20),
            Expanded(child: ExpenseListWidget()),
          ],
        ),
      ),
    );
  }
}
