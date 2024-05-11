import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/setting.dart';
import 'package:expense_tracker_app/providers/setting/setting_repository_provider.dart';
import 'package:expense_tracker_app/services/api/base_api.dart';
import 'package:expense_tracker_app/services/api/category_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingNotifier extends AsyncNotifier<Setting> {
  @override
  Future<Setting> build() async {
    var response = await CategoryAPI().getCategories();
    List<Category> categories = [];

    if (response['status'] == APIResponse.success) {
      categories = Category().listFromJson(response['result']?['expenseCategories'] ?? []);
    }
    Setting setting = await ref.watch(settingRepositoryProvider).getSetting();
    setting = setting.copy(categories: categories);
    return setting;
  }

  Future<void> updateSetting(Setting setting) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(settingRepositoryProvider).updateSetting(setting);
      Setting updatedSetting = await ref.watch(settingRepositoryProvider).getSetting();
      updatedSetting = updatedSetting.copy(categories: state.value?.categories);
      return Future.value(updatedSetting);
    });
  }

  Future<void> updateMonthlyBudget({double deductAmount = 0, double oldAmount = 0}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      Setting currentSetting = state.value ?? Setting();
      final newMonthlyBudget = currentSetting.monthlyBudget - deductAmount + oldAmount;
      currentSetting = currentSetting.copy(monthlyBudget: newMonthlyBudget);
      await ref.watch(settingRepositoryProvider).updateSetting(currentSetting);
      return Future.value(currentSetting);
    });
  }
}
