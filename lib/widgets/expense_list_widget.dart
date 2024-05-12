import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense/expenses_provider.dart';
import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseListWidget extends ConsumerStatefulWidget {
  const ExpenseListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ExpenseListWidgetState();
}

class ExpenseListWidgetState extends ConsumerState<ExpenseListWidget> {
  List<String> selectedCategories = [];
  String selectedSortBy = Constants.expenseSortByList.first;

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(expensesProvider);
    final setting = ref.watch(settingProvider).requireValue;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expenses',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            IconButton(
              onPressed: () async {
                var result = await Navigator.pushNamed(context, Constants.expenseFilterRoute, arguments: {
                  'selectedCategories': selectedCategories,
                  'sortBy': selectedSortBy,
                });

                if (result != null && result is Map<String, dynamic>) {
                  selectedCategories = result['categories'] ?? [];
                  selectedSortBy = result['sortBy'] ?? Constants.expenseSortByList.first;
                  ref.read(expensesProvider.notifier).filterRecord(categories: result['categories'], sortBy: result['sortBy']!);
                }
              },
              icon: Row(
                children: [
                  Text(
                    'Filter',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 4),
                  Badge(
                    isLabelVisible: selectedCategories.isNotEmpty || selectedSortBy != Constants.expenseSortByList.first,
                    child: Icon(
                      Icons.filter_alt_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: expenses.when(
              data: (List<Expense> value) {
                if (value.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'You dont have any expenses yet.',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Constants.addExpenseRoute);
                        },
                        child: const Text('Add Expense'),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final Expense expense = value[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Constants.editExpenseRoute, arguments: expense.id);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          title: Text(
                            expense.formattedDate,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          subtitle: Text(
                            expense.category ?? 'No category',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),
                          ),
                          trailing: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              '${setting.currency} ${expense.displayAmount}',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 2,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              error: (e, st) => const Center(child: Text('Unable to load expenses')),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}
