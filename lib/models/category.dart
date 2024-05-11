import 'package:expense_tracker_app/models/base_model.dart';
import 'package:flutter/material.dart';

class Category extends BaseModel<Category> {
  final String name;
  final double? totalAmount;
  final double? recommendedPercentage;
  final bool? isFixed;

  Category({
    this.name = '',
    this.totalAmount,
    this.recommendedPercentage,
    this.isFixed,
  });

  Color get color {
    switch (name) {
      case 'Food':
        return Colors.cyan;
      case 'Transportation':
        return Colors.blue;
      case 'Housing':
        return Colors.amber;
      case 'Utilities':
        return Colors.green;
      case 'Insurance':
        return Colors.purple;
      case 'Debt Repayment':
        return Colors.orange;
      case 'Savings':
        return Colors.red;
      case 'Investing':
        return Colors.teal;
      case 'Personal Care':
        return Colors.pink;
      case 'Clothing':
        return Colors.indigo;
      case 'Entertainment':
        return Colors.lime;
      case 'Gifts':
        return Colors.brown;
      case 'Pet Expenses':
        return Colors.deepOrange;
      case 'Miscellaneous':
        return Colors.deepPurple;
      case 'Others':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      recommendedPercentage: double.tryParse(json['recommendedPercentage']?.toString() ?? ''),
      isFixed: json['isFixed'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'recommendedPercentage': recommendedPercentage,
      'isFixed': isFixed,
    };
  }

  Category fromGroupByJson(Map<String, dynamic> json) {
    return Category(
      name: json['category'],
      totalAmount: json['total'],
    );
  }
}
