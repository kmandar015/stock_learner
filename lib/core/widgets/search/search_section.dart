import 'package:flutter/material.dart';
import 'package:stock_learner/core/widgets/search/search.dart';
import 'package:stock_learner/core/widgets/search/search_box/seach_box.dart';
import 'package:stock_learner/core/widgets/widgets/base_list.dart';
import 'package:stock_learner/core/widgets/widgets/standard/header.dart';

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseList(children: [
      StandardHeader(
        title: 'Search',
        subtitle: 'Search Companies',
        action: Container(),
      ),

      // Search Box.
      const SizedBox(height: 16),
      const SearchBoxWidget(),
      const SizedBox(height: 16),
      SearchScreenSection()
    ]);
  }
}
