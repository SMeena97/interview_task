part of 'search_bloc.dart';

class SearchState {
  final List<SearchModel> searchResults;
  final bool hasReachedMax;
  int currentPage;
  final int totalPages;

  SearchState({
    required this.searchResults,
    required this.hasReachedMax,
    required this.currentPage,
    required this.totalPages,
  });

  factory SearchState.initial() {
    return SearchState(
      searchResults: [],
      hasReachedMax: false,
      currentPage: 1,
      totalPages: 1,
    );
  }

  SearchState copyWith({
    List<SearchModel>? searchResults,
    bool? hasReachedMax,
    int? currentPage,
    int? totalPages,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
