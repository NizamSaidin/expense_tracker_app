import 'package:expense_tracker_app/models/base_model.dart';
import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/utils/constants.dart';

class Setting extends BaseModel<Setting> {
  final int id;
  final double monthlyBudget;
  final String currency;
  final List<Category> categories;

  Setting({this.id = 1, this.monthlyBudget = 0, currency, this.categories = const []}) : currency = currency ?? Constants.currencyList.first;

  String get monthlyBudgetAmountDisplayText => '$currency $monthlyBudgetAmountText';

  String get monthlyBudgetAmountText => monthlyBudget.toStringAsFixed(2);

  @override
  Setting fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json['id'],
      monthlyBudget: json['monthly_budget'],
      currency: json['currency'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'monthly_budget': monthlyBudget,
      'currency': currency,
    };
  }

  @override
  Setting copy({double? monthlyBudget, String? currency, List<Category>? categories}) {
    return Setting(
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      currency: currency ?? this.currency,
      categories: categories ?? this.categories,
    );
  }
}
