import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense/expenses_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expensesProvider = AsyncNotifierProvider<ExpensesNotifier, List<Expense>>(ExpensesNotifier.new);
