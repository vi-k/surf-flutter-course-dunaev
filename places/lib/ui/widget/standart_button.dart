import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_theme.dart';

class StandartButton extends StatelessWidget {
  const StandartButton({
    Key? key,
    this.svg,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String? svg;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final textStyle = theme.standartButtonTextStyle;

    return svg == null
      ? RaisedButton(
          color: theme.app.buttonTheme.colorScheme?.primary,
          onPressed: onPressed,
          child: Text(
            label,
            style: textStyle,
          ),
        )
      : RaisedButton.icon(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            svg!,
            color: textStyle.color,
          ),
          label: Text(
            label,
            style: textStyle,
          ),
        );
  }
}
