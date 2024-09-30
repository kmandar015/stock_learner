import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:stock_learner/core/bloc/news/news_bloc.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/widgets/news/news.dart';
import 'package:stock_learner/core/widgets/widgets/empty_screen.dart';
import 'package:stock_learner/core/widgets/widgets/standard/header.dart';


class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: OfflineBuilder(
        child: Container(),
        connectivityBuilder: ( context,  connectivity, child,  ) {
          return connectivity == ConnectivityResult.none 
          ? _buildNoConnectionMessage(context)
          : _buildContent(context);
        }
      )
    );
  }

  Widget _buildNoConnectionMessage(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 14,
        left: 24,
        right: 24
      ),
      child: EmptyScreen(message: 'Looks like you don\'t have an internet connection.'),
    );
  }

  Widget _buildContent(context) {
    return RefreshIndicator(
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [

            StandardHeader(
              title: 'Latest News',
              subtitle: 'Portfolio Related',
              action: Container(),
            ),

            NewsSectionWidget()
          ]
        )
      ),

      onRefresh: () async {
        // Reload markets section.
        BlocProvider
        .of<NewsBloc>(context)
        .add(FetchNews());
      },
    );
  }
}