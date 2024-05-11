import 'package:expense_tracker_app/models/base_model.dart';
import 'package:intl/intl.dart';

class Expense extends BaseModel<Expense> {
  final int? id;
  final String? category;
  final double? amount;
  final String? date;
  final String? note;

  Expense({this.id, this.category, this.amount, this.date, this.note});

  String get formattedDate {
    if (date != null) {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date!));
    }
    return '';
  }

  String get displayAmount {
    if (amount != null) {
      return NumberFormat.simpleCurrency(name: '').format(amount);
    }
    return '';
  }

  String get formattedAmount {
    if (amount != null) {
      return NumberFormat('0.00').format(amount);
    }
    return '';
  }

  DateTime get dateTime {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').parse(date!);
    }
    return DateTime.now();
  }

  @override
  Expense fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      amount: json['amount'],
      date: json['date'],
      note: json['note'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'amount': amount,
      'date': date,
      'note': note,
    };
  }

  Expense fromGroupByDayJson(Map<String, dynamic> json) {
    return Expense(
      date: json['date'],
      amount: json['total'],
    );
  }
}
