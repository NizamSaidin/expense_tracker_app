import 'package:expense_tracker_app/models/setting.dart';
import 'package:expense_tracker_app/providers/setting/setting_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingProvider = AsyncNotifierProvider<SettingNotifier, Setting>(SettingNotifier.new);
