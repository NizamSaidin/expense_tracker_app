import 'package:expense_tracker_app/repositories/setting_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingRepositoryProvider = Provider<SettingRepository>((ref) {
  return SettingRepository();
});
