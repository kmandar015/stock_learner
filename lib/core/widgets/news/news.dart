import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/bloc/news/news_bloc.dart';
import 'package:stock_learner/core/widgets/news/news_card/news_card.dart';
import 'package:stock_learner/core/widgets/widgets/empty_screen.dart';
import 'package:stock_learner/core/widgets/widgets/loading_indicator.dart';


class NewsSectionWidget extends StatelessWidget {
  const NewsSectionWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (BuildContext context, NewsState state) {

        if (state is NewsInitial) {
          BlocProvider
          .of<NewsBloc>(context)
          .add(FetchNews());
        }

        if (state is NewsError) {
          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: EmptyScreen(message: state.message),
          );
        }

        if (state is NewsLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.news.length,
            itemBuilder: (BuildContext context, int index) {

              // Ensure that we don't have empty headlines.
              if (state.news[index].news.isEmpty ) {
                return EmptyScreen(message: 'There are no news related to ${state.news[index].keyWord}.');
              }

              return NewsCardWidget(
                title: state.news[index].keyWord,
                news: state.news[index].news,
              );
            },
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 3,
            left: 4,
            right: 4
          ),
          child: LoadingIndicatorWidget(),
        );
      }
    );
  }

}
