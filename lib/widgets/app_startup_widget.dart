import 'package:expense_tracker_app/providers/setting/setting_provider.dart';
import 'package:expense_tracker_app/widgets/app_error_widget.dart';
import 'package:expense_tracker_app/widgets/app_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget class to manage asynchronous app initialization
class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});

  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingState = ref.watch(settingProvider);
    return settingState.when(
      data: (_) => onLoaded(context),
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(settingProvider),
      ),
    );
  }
}
