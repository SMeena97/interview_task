import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:interview_task/model/search_model.dart';
import 'package:interview_task/service/service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  SearchBloc() : super(SearchState.initial()) {
    on<PerformSearch>((event, emit) async {
      try {
        var results =
            await ApiService.searchItems(search: event.query, page: event.page);

        if (event.page == 1) {
          state.searchResults.clear();
        }
        emit(state.copyWith(
          searchResults: List.of(state.searchResults)..addAll(results),
          hasReachedMax: event.page >= state.totalPages,
          currentPage: event.page,
        ));
      } catch (e) {
        // Handle error, log, etc.
      }
    });

    on<OnLoad>((event, emit) async {
      try {
        state.currentPage = event.page;
        print(
            'page----->${event.page}/${state.currentPage}/${state.totalPages}');
        var results =
            await ApiService.searchItems(search: event.query, page: event.page);

        emit(state.copyWith(
          searchResults: List.of(state.searchResults)..addAll(results),
          hasReachedMax: event.page >= state.totalPages,
          currentPage: state.currentPage,
        ));

        refreshController.loadComplete();
      } catch (e) {
        // Handle error, log, etc.
      }
    });

    on<OnRefresh>((event, emit) async {
      try {
        var results = await ApiService.searchItems(
          search: event.query,
        );

        state.searchResults.clear();
        emit(state.copyWith(
          searchResults: List.of(state.searchResults)..addAll(results),
          hasReachedMax: 1 >= state.totalPages,
          currentPage: 1,
        ));

        refreshController.refreshCompleted();
      } catch (e) {
        // Handle error, log, etc.
      }
    });
  }
}
