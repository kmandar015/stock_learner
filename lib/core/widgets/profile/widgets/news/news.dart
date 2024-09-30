import 'package:flutter/material.dart';
import 'package:stock_learner/core/models/profile/news/stock_news.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/utils/url/url.dart';
import 'package:stock_learner/core/widgets/profile/widgets/styles.dart';

class ProfileNewsScreen extends StatelessWidget {

  final List<StockNews> news;

  ProfileNewsScreen({
    required this.news
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 26, right: 26, top: 26),
      children: <Widget>[
        const Text('Latest News', style: kProfileCompanyName),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: news.length,
          itemBuilder: (BuildContext context, int i) => _buildNewsCard(news[i])
        )
      ],
    );
  }

  Widget _buildNewsCard(StockNews singleNew) {
    return GestureDetector(
      onTap: () => launchUrl(singleNew.url),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            singleNew.source,
            style: const TextStyle(
              color: kLighterGray,
              fontWeight: FontWeight.w600
            ),
          ),  
          const SizedBox(height: 8),
          Text(
            singleNew.headline, style: const TextStyle(
              height: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ), 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            singleNew.summary, style: const TextStyle(
              color:  kLighterGray,
              height: 1.8,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }
}