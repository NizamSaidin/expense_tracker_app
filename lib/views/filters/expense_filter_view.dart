import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFilterView extends ConsumerStatefulWidget {
  const ExpenseFilterView({Key? key, this.filteredCategories, this.selectedSortBy}) : super(key: key);
  final List<String>? filteredCategories;
  final String? selectedSortBy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ExpenseFilterViewState();
}

class ExpenseFilterViewState extends ConsumerState<ExpenseFilterView> {
  final List<String> _selectedCategories = [];
  String _selectedSortBy = Constants.expenseSortByList.first;

  @override
  void initState() {
    super.initState();
    if (widget.filteredCategories != null) {
      _selectedCategories.addAll(widget.filteredCategories!);
    }
    if (widget.selectedSortBy != null) {
      _selectedSortBy = widget.selectedSortBy!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final setting = ref.read(settingProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Expenses'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: setting.categories
                        .map(
                          (category) => FilterChip(
                            label: Text(category.name),
                            selected: _selectedCategories.contains(category.name),
                            onSelected: (value) {
                              setState(() {
                                if (_selectedCategories.contains(category.name)) {
                                  _selectedCategories.remove(category.name);
                                } else {
                                  _selectedCategories.add(category.name);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sort By',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  DropdownMenu<String>(
                    initialSelection: _selectedSortBy,
                    inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          isDense: true,
                        ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    onSelected: (String? value) {
                      if (value != null) {
                        // This is called when the user selects an item.
                        setState(() {
                          _selectedSortBy = value;
                        });
                      }
                    },
                    dropdownMenuEntries: Constants.expenseSortByList.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
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
                onPressed: () {
                  setState(() {
                    _selectedCategories.clear();
                    _selectedSortBy = Constants.expenseSortByList.first;
                  });
                },
                child: const Text('Clear All Filters'),
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
                onPressed: () {
                  Navigator.pop(context, {
                    'categories': _selectedCategories,
                    'sortBy': _selectedSortBy,
                  });
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
