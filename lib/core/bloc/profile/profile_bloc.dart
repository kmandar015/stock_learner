import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/models/profile/profile.dart';
import 'package:stock_learner/core/respository/portfolio/storage_client.dart';
import 'package:stock_learner/core/respository/profile/client.dart';
import 'package:stock_learner/core/utils/sentry_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _httpClient = ProfileClient();
  final _storageClient = PortfolioStorageClient();

  ProfileBloc() : super(ProfileInitial());

  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileData) {
      yield ProfileLoading();
      yield* _mapProfileState(symbol: event.symbol);
    }
  }

  Stream<ProfileState> _mapProfileState({required String symbol}) async* {
    try {
      yield ProfileLoaded(
          profileModel: await this._httpClient.fetchStockData(symbol: symbol),
          isSymbolSaved:
              await this._storageClient.symbolExists(symbol: symbol));
    } catch (e, stack) {
      yield ProfileLoadingError(error: 'Symbol not supported.');
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
