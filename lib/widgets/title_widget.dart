import 'package:expense_tracker_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.showSettingIcon = false});

  final String title;
  final bool showSettingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                height: 1.1,
              ),
        ),
        Visibility(
          visible: showSettingIcon,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Constants.settingsRoute);
            },
            icon: const Icon(Icons.settings, size: 30),
          ),
        )
      ],
    );
  }
}
