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

  ProfileBloc() : super(ProfileInitial()) {
    // Registering the handler for the FetchProfileData event
    on<FetchProfileData>((event, emit) async {
      emit(ProfileLoading());
      await _mapProfileState(emit, symbol: event.symbol);
    });
  }

  // Refactored _mapProfileState to use emit instead of yield
  Future<void> _mapProfileState(Emitter<ProfileState> emit,
      {required String symbol}) async {
    try {
      final profileModel = await _httpClient.fetchStockData(symbol: symbol);
      final isSymbolSaved = await _storageClient.symbolExists(symbol: symbol);

      emit(ProfileLoaded(
          profileModel: profileModel, isSymbolSaved: isSymbolSaved));
    } catch (e, stack) {
      emit(ProfileLoadingError(error: 'Symbol not supported.'));
      await SentryHelper(exception: e, stackTrace: stack).report();
    }
  }
}
