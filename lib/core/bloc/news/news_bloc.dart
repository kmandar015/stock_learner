import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/models/news/news.dart';
import 'package:stock_learner/core/respository/news/repository.dart';
import 'package:stock_learner/core/respository/portfolio/storage_client.dart';
import 'package:stock_learner/core/utils/sentry_helper.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final _newsRepository = NewsRepository();
  final _databaseRepository = PortfolioStorageClient();

  NewsBloc() : super(NewsInitial()) {
    // Registering the handler for the FetchNews event
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      await _fetchNews(emit);
    });
  }

  // Refactored _fetchNews to use emit instead of yield
  Future<void> _fetchNews(Emitter<NewsState> emit) async {
    try {
      final symbolsStored = await _databaseRepository.fetch();

      if (symbolsStored.isNotEmpty) {
        final news = await Future.wait(symbolsStored.map((symbol) async =>
            await _newsRepository.fetchNews(title: symbol.companyName)));

        emit(NewsLoaded(news: news));
      } else {
        final news = await Future.wait(['Dow Jones', 'S&P 500', 'Nasdaq'].map(
            (symbol) async => await _newsRepository.fetchNews(title: symbol)));

        emit(NewsLoaded(news: news));
      }
    } catch (e, stack) {
      emit(NewsError(message: 'There was an error loading news'));
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
