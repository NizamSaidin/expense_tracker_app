import 'package:expense_tracker_app/utils/constants.dart';
import 'package:expense_tracker_app/views/partial/dashboard_view.dart';
import 'package:expense_tracker_app/views/partial/statistic_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  // list tabs here
  final List<Widget> tabs = [
    const DashboardView(),
    Container(),
    const StatisticView(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, Constants.addExpenseRoute);
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: tabs,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonTheme.colorScheme?.outlineVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, size: 35),
              ),
              label: 'Business',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
