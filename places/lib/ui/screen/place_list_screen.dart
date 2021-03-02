import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/const.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/widget/app_navigation_bar.dart';
import 'package:places/ui/widget/failed.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:places/ui/widget/place_card_grid.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/sliver_floating_header.dart';
import 'package:provider/provider.dart';

import 'place_edit_screen.dart';
import 'search_screen.dart';

/// Экран списка мест.
class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  Widget build(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();
    final theme = MyTheme.of(context);
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;
    final columnsCount = aspectRatio <= 4 / 5
        ? 1
        : aspectRatio <= 5 / 4
            ? 2
            : 3;

    return Loader<List<Place>>(
      load: () => placeInteractor.getPlaces(filter),
      error: (context, error) => Scaffold(
        body: Padding(
          padding: commonPadding,
          child: Failed(
            message: error.toString(),
            onRepeat: () => Loader.of<List<Place>>(context).reload(),
          ),
        ),
      ),
      builder: (context, _, places) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            _buildHeader(context, theme, columnsCount),
          ],
          body: RefreshIndicator(
            onRefresh: () async => Loader.of<List<Place>>(context).reload(),
            child: CustomScrollView(
              slivers: [
                PlaceCardGrid(
                  cardType: Favorite.no,
                  places: places,
                  asSliver: true,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: columnsCount == 2
            ? FloatingActionButton(
                onPressed: () => _newPlace(context),
                child: const Icon(Icons.add),
              )
            : FloatingActionButton.extended(
                isExtended: true,
                onPressed: () => _newPlace(context),
                icon: const Icon(Icons.add),
                label: Text(stringNewPlace.toUpperCase()),
              ),
        bottomNavigationBar: const AppNavigationBar(index: 0),
      ),
    );
  }

  Widget _buildHeader(
          BuildContext context, MyThemeData theme, int columnsCount) =>
      SliverFloatingHeader(
        key: ValueKey(filter),
        title: stringPlaceList,
        bottom: SearchBar(
          onTap: () async {
            await Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
          filter: filter,
          onFilterChanged: (newFilter) {
            filter = newFilter;
            Loader.of<List<Place>>(context).reload();
          },
        ),
        bottomHeight: smallButtonHeight,
      );

  Future<void> _newPlace(BuildContext context) async {
    final place = await Navigator.push<Place>(
        context,
        MaterialPageRoute(
          builder: (context) => const PlaceEditScreen(),
        ));
    if (place != null) Loader.of<List<Place>>(context).reload();
  }
}
