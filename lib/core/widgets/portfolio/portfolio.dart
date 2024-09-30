import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/widgets/portfolio/portfolio_stonks.dart';
import 'package:stock_learner/core/widgets/portfolio/widgets/heading/portfolio_heading.dart';

import '../../bloc/portfolio/portfolio_bloc.dart';
import '../widgets/empty_screen.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldBackground,
        body: OfflineBuilder(
            child: Container(),
            connectivityBuilder: (
              context,
              connectivity,
              child,
            ) {
              return connectivity == ConnectivityResult.none
                  ? _buildNoConnectionMessage(context)
                  : _buildContent(context);
            }));
  }

  Widget _buildNoConnectionMessage(context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 14, left: 24, right: 24),
      child: EmptyScreen(
          message: 'Looks like you don\'t have an internet connection.'),
    );
  }

  Widget _buildContent(context) {
    return RefreshIndicator(
      child: SafeArea(
          child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [PortfolioHeadingSection(), PortfolioStonksSection()])),
      onRefresh: () async {
        // Reload stocks section.
        BlocProvider.of<PortfolioBloc>(context).add(FetchPortfolioData());
      },
    );
  }
}
