import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/bloc/profile/profile_bloc.dart';
import 'package:stock_learner/core/models/data_overview.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/shared/styles.dart';
import 'package:stock_learner/core/utils/color/color_helper.dart';
import 'package:stock_learner/core/utils/text/text_helper.dart';
import 'package:stock_learner/core/widgets/profile/profile.dart';


class PortfolioStockCard extends StatelessWidget {

  final StockOverviewModel data;

  const PortfolioStockCard({super.key,
    required this.data
  });

  static const _kCompanyNameStyle = TextStyle(
    color: Color(0XFFc2c2c2),
    fontSize: 13,
    height: 1.5
  );

  static const _kStockTickerSymbol = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold
  );

  static const _kStockPriceStyle = TextStyle(
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: MaterialButton(
        color: kTileColor,

        shape: RoundedRectangleBorder(borderRadius: kStandatBorder),
        onPressed: () {

          // Trigger fetch event.
          BlocProvider
            .of<ProfileBloc>(context)
            .add(FetchProfileData(symbol: data.symbol));

          // Send to Profile.
          Navigator.push(context, MaterialPageRoute(builder: (_) => Profile(symbol: data.symbol)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 8, child: _buildCompanyData()),
              Expanded(flex: 4,child: _buildPriceData())
            ],
          ),
        ),
      ),
    );
  }

  /// This method is in charge of rendering the stock company data.
  /// This is the left side in the card. 
  /// It renders the  [symbol] and the company [name] from [data].
  Widget _buildCompanyData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(data.symbol, style: _kStockTickerSymbol),
        const SizedBox(height: 4.0),
        Text(data.name, style: _kCompanyNameStyle,)
      ], 
    );
  }
  
  /// This method is in charge of rendering the stock company data.
  /// This is the right side in the card. 
  /// It renders the [change] and the stock's [price] from [data].
  Widget _buildPriceData() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            width: data.changesPercentage > 99.99 ? null : 75.5,

            decoration: BoxDecoration(
              borderRadius: kSharpBorder,
              color: determineColorBasedOnChange(data.change)
            ),

            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(determineTextBasedOnChange(data.change), textAlign: TextAlign.end),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(formatText(data.price), 
            textAlign: TextAlign.end, 
            style: _kStockPriceStyle
          ),
        ),
      ],
    );
  }
}
