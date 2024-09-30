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

  SearchBloc() : super(SearchInitial());

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchSearchHistory) {
      yield SearchLoading();
      yield* _fetchSavedSearches();
    }

    if (event is SaveSearch) {
      await this._client.save(symbol: event.symbol);
      yield* _fetchSavedSearches();
    }

    if (event is DeleteSearch) {
      await this._client.delete(symbol: event.symbol);
      yield* _fetchSavedSearches();
    }

    if (event is FetchSearchResults) {
      yield SearchLoading();

      bool hasConnection = await InternetConnection().hasInternetAccess;

      if (hasConnection) {
        yield* _fetchSearchResults(symbol: event.symbol);
      } else {
        yield SearchResultsLoadingError(message: 'No internet connection');
      }
    }
  }

  Stream<SearchState> _fetchSavedSearches() async* {
    yield SearchLoading();

    final data = await this._client.fetch();

    yield data.isEmpty
        ? SearchResultsLoadingError(message: 'No recent searches')
        : SearchData(data: data, listType: ListType.searchHistory);
  }

  Stream<SearchState> _fetchSearchResults({required String symbol}) async* {
    try {
      final data = await this._client.searchStock(symbol: symbol);

      yield data.isEmpty
          ? SearchResultsLoadingError(message: 'No results were found')
          : SearchData(data: data, listType: ListType.searchResults);
    } catch (e, stack) {
      yield SearchResultsLoadingError(message: 'There was an error loading');
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
