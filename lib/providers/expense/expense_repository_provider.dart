import 'package:expense_tracker_app/repositories/expense_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});
