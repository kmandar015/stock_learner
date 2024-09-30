import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/models/data_overview.dart';
import 'package:stock_learner/core/models/profile/market_index.dart';
import 'package:stock_learner/core/models/storage/storage.dart';
import 'package:stock_learner/core/respository/portfolio/client.dart';
import 'package:stock_learner/core/respository/portfolio/storage_client.dart';
import 'package:stock_learner/core/utils/sentry_helper.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final _databaseRepository = PortfolioStorageClient();
  final _repository = PortfolioClient();

  // Constructor that expects an initial state
  PortfolioBloc() : super(PortfolioInitial());

  @override
  PortfolioState get initialState => PortfolioInitial();

  @override
  Stream<PortfolioState> mapEventToState(PortfolioEvent event) async* {
    if (event is FetchPortfolioData) {
      yield PortfolioLoading();
      yield* _loadContent();
    }

    if (event is SaveProfile) {
      yield PortfolioLoading();
      await _databaseRepository.save(storageModel: event.storageModel);
      yield* _loadContent();
    }

    if (event is DeleteProfile) {
      yield PortfolioLoading();
      await _databaseRepository.delete(symbol: event.symbol);
      yield* _loadContent();
    }
  }

  Stream<PortfolioState> _loadContent() async* {
    try {
      final symbolsStored = await _databaseRepository.fetch();
      final indexes = await _repository.fetchIndexes();

      if (symbolsStored.isNotEmpty) {
        final stocks = await Future.wait(symbolsStored.map((symbol) async =>
            await _repository.fetchStocks(symbol: symbol.symbol)));

        yield PortfolioLoaded(stocks: stocks, indexes: indexes);
      } else {
        yield PortfolioStockEmpty(indexes: indexes);
      }
    } catch (e, stack) {
      yield PortfolioError(
          message: 'There was an unknown error. Please try again later.');
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
