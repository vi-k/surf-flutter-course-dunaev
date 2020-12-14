import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/const.dart';

class StandartButton extends StatelessWidget {
  const StandartButton({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final Widget? icon;
  final Widget label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => icon == null
      ? FlatButton(
          color: standartButtonColor,
          height: standartButtonHeight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(standartButtonRadius),
            ),
          ),
          onPressed: onPressed,
          child: label,
        )
      : FlatButton.icon(
          color: standartButtonColor,
          height: standartButtonHeight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(standartButtonRadius),
            ),
          ),
          onPressed: onPressed,
          icon: icon!,
          label: label,
        );
}