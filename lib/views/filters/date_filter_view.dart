import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilterView extends StatefulWidget {
  const DateFilterView({Key? key, this.selectedYear, this.selectedMonth}) : super(key: key);
  final int? selectedYear;
  final int? selectedMonth;

  @override
  State<DateFilterView> createState() => _DateFilterViewState();
}

class _DateFilterViewState extends State<DateFilterView> {
  List<int> years = List.generate(8, (index) => DateTime.now().year - 5 + index);
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.selectedYear ?? DateTime.now().year;
    _selectedMonth = widget.selectedMonth ?? DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
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
                    'Select year',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: years
                        .map(
                          (year) => FilterChip(
                            label: Text(year.toString()),
                            selected: _selectedYear == year,
                            onSelected: (value) {
                              setState(() {
                                _selectedYear = year;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select Month',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(12, (index) => index + 1)
                        .map(
                          (month) => FilterChip(
                            label: Text(DateFormat('MMMM').format(DateTime(DateTime.now().year, month))),
                            selected: _selectedMonth == month,
                            onSelected: (value) {
                              setState(() {
                                _selectedMonth = month;
                              });
                            },
                          ),
                        )
                        .toList(),
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
                    _selectedYear = DateTime.now().year;
                    _selectedMonth = DateTime.now().month;
                  });
                },
                child: const Text('Reset'),
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
                  Navigator.pop(context, DateTime(_selectedYear, _selectedMonth));
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
