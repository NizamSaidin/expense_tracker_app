import 'package:expense_tracker_app/models/setting.dart';
import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/utils/constants.dart';
import 'package:expense_tracker_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingsViewState();
}

class SettingsViewState extends ConsumerState<SettingsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _monthlyBudgetController = TextEditingController();
  String? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    final setting = ref.read(settingProvider).requireValue;
    _monthlyBudgetController.text = setting.monthlyBudgetAmountText;
    _selectedCurrency = setting.currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
                      TextFormField(
                        controller: _monthlyBudgetController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Monthly Budget',
                          border: OutlineInputBorder(),
                          isDense: true,
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
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Select Default Currency',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        value: _selectedCurrency,
                        items: Constants.currencyList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          _selectedCurrency = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select currency';
                          }
                          return null;
                        },
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
                    Setting updatedSetting = Setting(
                      id: ref.read(settingProvider).requireValue.id,
                      monthlyBudget: double.parse(_monthlyBudgetController.text),
                      currency: _selectedCurrency!,
                    );

                    await ref.read(settingProvider.notifier).updateSetting(updatedSetting);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
