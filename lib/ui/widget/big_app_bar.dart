import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/app/app_bloc.dart';

import 'package:places/ui/res/const.dart';

/// Большой AppBar (для страницы списка интересных мест).
class BigAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BigAppBar({
    Key? key,
    required this.title,
    this.bottom,
  }) : super(key: key);

  /// Заголовок.
  final String title;

  /// Виджет под AppBar'ом.
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppBloc>().theme;

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: appBarPadding,
            child: Text(title, style: theme.textBold32Main),
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(400);
}
