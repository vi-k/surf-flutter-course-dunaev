import 'package:flutter/material.dart';

import '../res/const.dart';

/// Прогресс-индикатор загрузки для [Loadable] для небольших виджетов.
class SmallLoader extends StatelessWidget {
  const SmallLoader({
    Key? key,
    this.color,
  }) : super(key: key);

  /// Цвет прогресс-индикатора.
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: commonSpacing,
        height: commonSpacing,
        child: CircularProgressIndicator(
          valueColor:
              color == null ? null : AlwaysStoppedAnimation<Color>(color!),
          strokeWidth: 2,
        ),
      );
}
