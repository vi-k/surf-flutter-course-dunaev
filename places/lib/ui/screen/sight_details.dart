import 'package:flutter/material.dart';

import '../../domain/sight.dart';
import '../res/strings.dart';
import '../res/themes.dart';
import '../widget/loadable_image.dart';
import '../widget/small_button.dart';
import '../widget/standart_button.dart';

class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  _SightDetailsState createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MyThemeData.detailsImageSize,
                child: LoadableImage(url: widget.sight.url),
              ),
              Padding(
                padding: MyThemeData.detailsPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.sight.name,
                      style: Theme.of(context).primaryTextTheme.headline2,
                    ),
                    const SizedBox(
                      height: MyThemeData.detailsTitleSpacing,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.sight.typeAsText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          width: MyThemeData.detailsHoursSpacing,
                        ),
                        Text(
                          'закрыто до 09:00', // Временно
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MyThemeData.detailsCommonSpacing,
                    ),
                    Text(
                      widget.sight.details,
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: MyThemeData.detailsCommonSpacing,
                    ),
                    StandartButton(
                      svg: assetRoute,
                      label: sightDetailsScreenRoute,
                      onPressed: () => print('Строим маршрут'),
                    ),
                    const SizedBox(
                      height: MyThemeData.detailsCommonSpacing,
                    ),
                    const Divider(
                      height: 0,
                    ),
                    const SizedBox(
                      height: MyThemeData.detailsFooterSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SmallButton(
                          // Неактивная кнопка
                          //onPressed: () => print('Запланировать'),
                          svg: assetCalendar,
                          label: sightDetailsScreenSchedule,
                        ),
                        SmallButton(
                          onPressed: () => print('В Избранное'),
                          svg: assetFavorite,
                          label: sightDetailsScreenFavorite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
