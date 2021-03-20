import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/data/repository/api_place_mapper.dart';
import 'package:places/data/repository/base/location_repository.dart';
import 'package:places/data/repository/shared_preferences_store_repository.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/place_list_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/app_bloc.dart';
import 'data/interactor/place_interactor.dart';
import 'data/repository/api_place_repository.dart';
import 'data/repository/base/mock_location_repository.dart';
import 'data/repository/base/place_repository.dart';
import 'data/repository/base/store_repository.dart';
import 'main.dart';
import 'ui/screen/splash_screen.dart';

/// Основной виджет-приложение.
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<StoreRepository>(
            create: (_) => SharedPreferencesStoreRepository(),
          ),
          Provider<PlaceRepository>(
            create: (_) => ApiPlaceRepository(dio, ApiPlaceMapper()),
          ),
          Provider<LocationRepository>(
            create: (_) => MockLocationRepository(),
          ),
          ProxyProvider2<PlaceRepository, LocationRepository, PlaceInteractor>(
            update: (_, placeRepository, locationRepository, __) =>
                PlaceInteractor(
              placeRepository: placeRepository,
              locationRepository: locationRepository,
            ),
          ),
        ],
        builder: (context, _) => BlocProvider<AppBloc>(
          create: (_) => AppBloc(
            context.read<StoreRepository>(),
            context.read<PlaceInteractor>(),
          )..add(const AppInit()),
          // error: (context, error) => MyTheme(
          //   myThemeData: myDarkTheme,
          //   child: Builder(
          //     builder: (context) => MaterialApp(
          //       title: 'Places',
          //       theme: MyTheme.of(context).app,
          //       home: Scaffold(
          //         body: Failed(
          //           message: 'Не удалось инициализировать приложение. '
          //               'Обратитесь к разработчику\n\n$error',
          //           onRepeat: () => Loader.of<Settings>(context).reload(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) => MaterialApp(
              // Без ключа тема обновляется с запозданием и происходит моргание.
              key: ValueKey(state),
              title: 'Places',
              theme: state is! AppReady
                  ? null
                  : context.watch<AppBloc>().theme.app,
              // Между этими строками и intl какой-то конфликт.
              // Без них работает. Но пропадает русификация в DatePicker.
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ru'),
              ],
              home: state is! AppReady
                  ? const SplashScreen()
                  : context.watch<AppBloc>().settings.showTutorial
                      ? OnboardingScreen()
                      : PlaceListScreen(),
            ),
          ),
        ),
      );
}
