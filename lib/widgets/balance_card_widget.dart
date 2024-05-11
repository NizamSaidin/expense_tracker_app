import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceCardWidget extends ConsumerWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(settingProvider).requireValue;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Balance',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    setting.monthlyBudgetAmountDisplayText,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.wallet_outlined,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
