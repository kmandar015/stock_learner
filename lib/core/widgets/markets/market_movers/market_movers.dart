import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/bloc/profile/profile_bloc.dart';
import 'package:stock_learner/core/models/markets/market_active/market_active.dart';
import 'package:stock_learner/core/shared/styles.dart';

import '../../profile/profile.dart';



class MarketMovers extends StatelessWidget {

  final MarketActiveModel data;
  final Color color;

  MarketMovers({
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: kStandatBorder,
          color: color,
        ),
        child: _buildContent(context),
      )
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      
      onTap: () {
        // Trigger fetch event.
        BlocProvider
          .of<ProfileBloc>(context)
          .add(FetchProfileData(symbol: data.ticker));

        // Send to Profile.
        Navigator.push(context, MaterialPageRoute(builder: (_) => Profile(symbol: data.ticker)));
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          // Ticker Symbol.
          Text(data.ticker, style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.5
          )),

          // Change percentage.
          const SizedBox(height: 5),
          Text(data.changesPercentage),
        ],
      ),
    );
  }
}