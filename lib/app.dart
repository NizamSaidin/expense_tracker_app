import 'package:expense_tracker_app/theme.dart';
import 'package:expense_tracker_app/utils/constants.dart';
import 'package:expense_tracker_app/views/expense/add_expense_view.dart';
import 'package:expense_tracker_app/views/expense/edit_expense_view.dart';
import 'package:expense_tracker_app/views/filters/date_filter_view.dart';
import 'package:expense_tracker_app/views/filters/expense_filter_view.dart';
import 'package:expense_tracker_app/views/home_view.dart';
import 'package:expense_tracker_app/views/settings/settings_view.dart';
import 'package:expense_tracker_app/widgets/app_startup_widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialTheme theme = MaterialTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'Expense Tracker App',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      highContrastTheme: theme.lightHighContrast(),
      routes: {
        Constants.homeRoute: (context) => AppStartupWidget(onLoaded: (context) => const HomeView()),
        Constants.addExpenseRoute: (context) => const AddExpenseView(),
        Constants.editExpenseRoute: (context) {
          int? id = ModalRoute.of(context)?.settings.arguments as int?;
          return EditExpenseView(id: id ?? -1);
        },
        Constants.settingsRoute: (context) => const SettingsView(),
        Constants.expenseFilterRoute: (context) {
          Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ExpenseFilterView(filteredCategories: arguments?['selectedCategories'], selectedSortBy: arguments?['sortBy']);
        },
        Constants.dateFilterRoute: (context) {
          Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return DateFilterView(selectedYear: arguments?['selectedYear'], selectedMonth: arguments?['selectedMonth']);
        },
      },
    );
  }
}
