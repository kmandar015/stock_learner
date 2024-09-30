import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/bloc/search/search_bloc.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                      child: TextFormField(
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(fontSize: 15.5),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<SearchBloc>(context).add(
                                  FetchSearchResults(
                                      symbol: value.toUpperCase()));
                            } else {
                              BlocProvider.of<SearchBloc>(context)
                                  .add(FetchSearchHistory());
                            }
                          })),
                ])),
      ],
    );
  }
}
