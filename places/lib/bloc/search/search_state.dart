part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

/// Загрузка результатов.
class SearchLoading extends SearchState {
  const SearchLoading();
}

/// Результаты поиска.
class SearchResults extends SearchState {
  const SearchResults(this.places);

  final List<Place> places;

  @override
  List<Object?> get props => [places];
}

/// Ошибка загрузки результатов поиска.
class SearchFailed extends SearchState {
  const SearchFailed(this.text, this.error) : super();

  final String text;
  final Exception error;

  @override
  List<Object?> get props => [text, error];
}

/// История поиска.
class SearchHistory extends SearchState {
  const SearchHistory(this.history);

  final List<SearchRequest> history;

  @override
  List<Object?> get props => [history];
}

/// Ошибка загрузки истории поиска.
class SearchHistoryFailed extends SearchState {
  const SearchHistoryFailed(this.error) : super();

  final Exception error;

  @override
  List<Object?> get props => [error];
}
