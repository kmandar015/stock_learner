import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/models/search/search.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:stock_learner/core/respository/search/search_client.dart';
import 'package:stock_learner/core/utils/sentry_helper.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _client = SearchClient();

  SearchBloc() : super(SearchInitial()) {
    // Event handlers
    on<FetchSearchHistory>((event, emit) async {
      emit(SearchLoading());
      await _fetchSavedSearches(emit);
    });

    on<SaveSearch>((event, emit) async {
      await _client.save(symbol: event.symbol);
      await _fetchSavedSearches(emit);
    });

    on<DeleteSearch>((event, emit) async {
      await _client.delete(symbol: event.symbol);
      await _fetchSavedSearches(emit);
    });

    on<FetchSearchResults>((event, emit) async {
      emit(SearchLoading());

      bool hasConnection = await InternetConnection().hasInternetAccess;

      if (hasConnection) {
        await _fetchSearchResults(emit, symbol: event.symbol);
      } else {
        emit(SearchResultsLoadingError(message: 'No internet connection'));
      }
    });
  }

  // Updated to use emit
  Future<void> _fetchSavedSearches(Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final data = await _client.fetch();

    emit(data.isEmpty
        ? SearchResultsLoadingError(message: 'No recent searches')
        : SearchData(data: data, listType: ListType.searchHistory));
  }

  Future<void> _fetchSearchResults(Emitter<SearchState> emit,
      {required String symbol}) async {
    try {
      final data = await _client.searchStock(symbol: symbol);

      emit(data.isEmpty
          ? SearchResultsLoadingError(message: 'No results were found')
          : SearchData(data: data, listType: ListType.searchResults));
    } catch (e, stack) {
      emit(SearchResultsLoadingError(message: 'There was an error loading'));
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
