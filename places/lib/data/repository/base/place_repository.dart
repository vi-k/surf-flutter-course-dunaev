import 'package:places/data/model/place_base.dart';
import 'package:places/utils/coord.dart';
import 'package:places/utils/enum.dart';
import 'package:places/utils/sort.dart';

import 'filter.dart';

/// Интерфейс для репозитория мест.
///
/// Возвращает список - [list]. И производит стандартные операции (CRUD):
/// [create], [read], [update] и [delete].
abstract class PlaceRepository {
  Future<int> create(PlaceBase place);
  Future<PlaceBase> read(int id);
  Future<void> update(PlaceBase place);
  Future<void> delete(int id);

  Future<List<PlaceBase>> list(
      {int? count,
      int? offset,
      PlaceOrderBy? pageBy,
      Object? pageLastValue,
      Map<PlaceOrderBy, Sort>? orderBy});

  Future<List<PlaceBase>> filteredList({Coord? coord, required Filter filter});
}

enum PlaceOrderBy { id, name }
extension PlaceOrderByExt on PlaceOrderBy {
  String get name => enumName(this);
}
