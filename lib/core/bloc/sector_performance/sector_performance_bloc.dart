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
  SectorPerformanceBloc() : super(SectorPerformanceInitial());

  @override
  SectorPerformanceState get initialState => SectorPerformanceInitial();

  @override
  Stream<SectorPerformanceState> mapEventToState(
      SectorPerformanceEvent event) async* {
    if (event is FetchSectorPerformance) {
      yield SectorPerformanceLoading();
      yield* _fetchData();
    }
  }

  Stream<SectorPerformanceState> _fetchData() async* {
    try {
      final client = MarketClient();

      yield SectorPerformanceLoaded(
          sectorPerformance: await client.fetchSectorPerformance(),
          marketActive: await client.fetchMarketActive(),
          marketGainer: await client.fetchMarketGainers(),
          marketLoser: await client.fetchMarketLosers());
    } catch (e, stack) {
      await SentryHelper(exception: e, stackTrace: stack).report();
      yield SectorPerformanceError(message: 'There was an unkwon error');
    }
  }
}
