import 'package:flutter/material.dart';
import 'package:stock_learner/core/models/profile/market_index.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/shared/styles.dart';
import 'package:stock_learner/core/utils/color/color_helper.dart';
import 'package:stock_learner/core/utils/text/text_helper.dart';

class PortfolioIndexWidget extends StatelessWidget {

  final MarketIndexModel index;

  const PortfolioIndexWidget({super.key,
    required this.index
  });

  static const _indexNameStyle = TextStyle(
   fontWeight: FontWeight.bold,
   fontSize: 16
  );

  static const _indexPriceStyle = TextStyle(
    fontSize: 14,
    color: kLightGray
  );

  static const _indexPriceChange = TextStyle(
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      
      padding: EdgeInsets.symmetric(horizontal: 4),
      
      child: Container(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(index.name, style: _indexNameStyle, maxLines: 1),      
            Text(formatText(index.price), style: _indexPriceStyle),     

            Container(
              decoration: BoxDecoration(
                borderRadius: kSharpBorder,
                color: determineColorBasedOnChange(index.change)
              ),
  
              width: 80,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(determineTextBasedOnChange(index.change), style: _indexPriceChange,),
            ),
          ]
        ),
      ),
      
      onPressed: () {},
    );
  }
}