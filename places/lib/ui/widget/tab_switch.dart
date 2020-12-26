import 'package:flutter/material.dart';

import '../res/themes.dart';
import 'my_theme.dart';
import 'small_button.dart';

/// Виджет: Переключатель табов.
class TabSwitch extends StatelessWidget {
  const TabSwitch({
    Key? key,
    required this.tabs,
    required this.tabController,
  }) : super(key: key);

  final List<String> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Container(
      height: MyThemeData.smallButtonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyThemeData.tabsSwitchRadius),
        color: theme.backgroundSecond,
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: SmallButton(
                onPressed: () {
                  tabController.index = i;
                },
                color: i == tabController.index
                    ? theme.mainTextColor
                    : Colors.transparent,
                label: tabs[i],
                style: i == tabController.index
                    ? theme.textBold14Inverse
                    : theme.textBold14Light,
              ),
            ),
        ],
      ),
    );
  }
}
