import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/providers/expense/expenses_provider.dart';
import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/providers/statistic/statistic_provider.dart';
import 'package:expense_tracker_app/utils/alert.dart';
import 'package:expense_tracker_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddExpenseView extends ConsumerStatefulWidget {
  const AddExpenseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddExpenseViewState();
}

class AddExpenseViewState extends ConsumerState<AddExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final setting = ref.watch(settingProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<Category>(
                        decoration: const InputDecoration(
                          hintText: 'Select category',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: setting.categories.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (Category? value) {
                          _selectedCategory = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: 'Enter Amount',
                          border: const OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 15, left: 12),
                            child: Text(
                              '${setting.currency} ',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return Utils.numericInputFieldFormatter(oldValue, newValue, maxValue: 9999999999.99);
                          }),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: Utils.validateAmount,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        controller: _dateController,
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((DateTime? value) {
                            if (value != null) {
                              _dateController.text = DateFormat('yyyy-MM-dd').format(value);
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          hintText: 'Notes',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final expense = Expense(
                      amount: double.parse(_amountController.text),
                      category: _selectedCategory!.name,
                      date: _dateController.text,
                      note: _noteController.text,
                    );
                    ref.read(expensesProvider.notifier).createExpense(expense).whenComplete(() {
                      ref.invalidate(expensesByDayProvider);
                      ref.invalidate(expenseCategoryProvider);
                    });
                    ref.read(settingProvider.notifier).updateMonthlyBudget(deductAmount: expense.amount!);
                    Navigator.pop(context);
                    Alert.showSnackbar(context, 'Expense successfully added');
                  }
                },
                child: const Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
