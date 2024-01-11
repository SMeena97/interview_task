part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;
  final int page;

  PerformSearch({required this.query, required this.page});
}

class OnRefresh extends SearchEvent {
  final String query;

  OnRefresh({required this.query});
}

class OnLoad extends SearchEvent {
  final String query;
  final int page;

  OnLoad({required this.query, required this.page});
}

class ClearSearch extends SearchEvent {}
