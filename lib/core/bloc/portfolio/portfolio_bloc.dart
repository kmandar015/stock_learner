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

  PortfolioBloc() : super(PortfolioInitial()) {
    // Registering the handlers for events
    on<FetchPortfolioData>((event, emit) async {
      emit(PortfolioLoading());
      await _loadContent(emit);
    });

    on<SaveProfile>((event, emit) async {
      emit(PortfolioLoading());
      await _databaseRepository.save(storageModel: event.storageModel);
      await _loadContent(emit);
    });

    on<DeleteProfile>((event, emit) async {
      emit(PortfolioLoading());
      await _databaseRepository.delete(symbol: event.symbol);
      await _loadContent(emit);
    });
  }

  Future<void> _loadContent(Emitter<PortfolioState> emit) async {
    try {
      final symbolsStored = await _databaseRepository.fetch();
      final indexes = await _repository.fetchIndexes();

      if (symbolsStored.isNotEmpty) {
        final stocks = await Future.wait(symbolsStored.map((symbol) async =>
            await _repository.fetchStocks(symbol: symbol.symbol)));

        emit(PortfolioLoaded(stocks: stocks, indexes: indexes));
      } else {
        emit(PortfolioStockEmpty(indexes: indexes));
      }
    } catch (e, stack) {
      emit(PortfolioError(
          message: 'There was an unknown error. Please try again later.'));
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
