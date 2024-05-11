import 'package:expense_tracker_app/utils/constants.dart';
import 'package:flutter/services.dart';

class Utils {
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter amount';
    }
    double? amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter valid amount';
    }

    if (amount > Constants.maxAmount) {
      return 'Amount exceeds limit';
    }
    return null;
  }

  static TextEditingValue numericInputFieldFormatter(TextEditingValue oldValue, TextEditingValue newValue, {double? maxValue, bool allowDecimal = true}) {
    TextEditingValue value = newValue.copyWith();
    // Check if the input is a valid integer with no leading zeroes
    if (value.text.isNotEmpty && int.tryParse(value.text) != null && value.text[0] != '0') {
      /// check if value is > 100
      if (maxValue != null && (int.tryParse(value.text) ?? 0) > maxValue) {
        return oldValue;
      }

      return value;
    }

    // Check if the input is a valid decimal number with no leading zeroes before the decimal point
    if (allowDecimal && value.text.isNotEmpty && double.tryParse(value.text) != null && value.text[0] != '0') {
      /// check if value is > 100
      if (maxValue != null && (double.tryParse(value.text) ?? 0) > maxValue) {
        return oldValue;
      }
      return value;
    }

    // Remove leading zeroes from the input
    while (value.text.startsWith('0') && value.text.length > 1 && value.text[1] != '.') {
      return TextEditingValue(text: newValue.text.substring(1), composing: newValue.composing, selection: TextSelection.fromPosition(TextPosition(offset: newValue.text.length - 1)));
    }

    return value;
  }
}
