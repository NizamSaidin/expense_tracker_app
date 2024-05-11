import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense/expense_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseCategoryProvider = FutureProvider.family<List<Category>, String>((ref, datetime) async {
  return await ref.watch(expenseRepositoryProvider).getExpensesGroupByCategory(DateTime.parse(datetime));
});

final expensesByDayProvider = FutureProvider.family<List<Expense>, String>((ref, datetime) async {
  return await ref.watch(expenseRepositoryProvider).getExpensesByDay(DateTime.parse(datetime));
});
