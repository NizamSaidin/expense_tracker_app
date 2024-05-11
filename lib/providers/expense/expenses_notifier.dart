import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense/expense_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesNotifier extends AsyncNotifier<List<Expense>> {
  @override
  Future<List<Expense>> build() async {
    return await ref.watch(expenseRepositoryProvider).getAllExpenses();
  }

  Future<List<Expense>> _fetchExpenses({List<String>? categories, String? sortBy}) async {
    return await ref.watch(expenseRepositoryProvider).getAllExpenses(categories: categories, sortBy: sortBy);
  }

  Future<void> createExpense(Expense expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(expenseRepositoryProvider).addExpense(expense);
      return _fetchExpenses();
    });
  }

  Future<Expense?> findExpenseById(int id) async {
    return await ref.watch(expenseRepositoryProvider).getExpenseById(id);
  }

  Future<void> updateExpense({required int id, required Expense expense}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(expenseRepositoryProvider).updateExpense(expense);
      return _fetchExpenses();
    });
  }

  Future<void> removeExpense(Expense expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(expenseRepositoryProvider).deleteExpense(expense);
      return _fetchExpenses();
    });
  }

  Future<void> filterRecord({List<String>? categories, String? sortBy}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchExpenses(categories: categories, sortBy: sortBy);
    });
  }
}
