import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/models/markets/market_active/market_active_model.dart';
import 'package:stock_learner/core/models/markets/sector_performance/sector_performance_model.dart';
import 'package:stock_learner/core/respository/market/market_client.dart';
import 'package:stock_learner/core/utils/sentry_helper.dart';

part 'sector_performance_event.dart';
part 'sector_performance_state.dart';

class SectorPerformanceBloc
    extends Bloc<SectorPerformanceEvent, SectorPerformanceState> {
  SectorPerformanceBloc() : super(SectorPerformanceInitial()) {
    // Registering the handler for the FetchSectorPerformance event
    on<FetchSectorPerformance>((event, emit) async {
      emit(SectorPerformanceLoading());
      await _fetchData(emit);
    });
  }

  // Refactored _fetchData to use emit instead of yield
  Future<void> _fetchData(Emitter<SectorPerformanceState> emit) async {
    try {
      final client = MarketClient();

      final sectorPerformance = await client.fetchSectorPerformance();
      final marketActive = await client.fetchMarketActive();
      final marketGainer = await client.fetchMarketGainers();
      final marketLoser = await client.fetchMarketLosers();

      emit(SectorPerformanceLoaded(
        sectorPerformance: sectorPerformance,
        marketActive: marketActive,
        marketGainer: marketGainer,
        marketLoser: marketLoser,
      ));
    } catch (e, stack) {
      await SentryHelper(exception: e, stackTrace: stack).report();
      emit(SectorPerformanceError(message: 'There was an unknown error'));
    }
  }
}
