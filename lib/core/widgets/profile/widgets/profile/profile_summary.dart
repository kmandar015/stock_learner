
import 'package:flutter/material.dart';
import 'package:stock_learner/core/models/profile/stock_profile.dart';
import 'package:stock_learner/core/models/profile/stock_quote.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/utils/text/text_helper.dart';
import 'package:stock_learner/core/widgets/profile/widgets/styles.dart';
class StatisticsWidget extends StatelessWidget {
  
  final StockQuote quote;
  final StockProfile profile;

  StatisticsWidget({
    required this.quote,
    required this.profile
  });

  static Text _renderText(dynamic text) {
    return text != null 
    ? Text(compactText(text))
    : const Text('-');
  }
  
  List<Widget> _leftColumn() {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Open', style: subtitleStyle),
        trailing: _renderText(quote.open)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Prev close', style: subtitleStyle),
        trailing: _renderText(quote.previousClose)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Day High', style: subtitleStyle),
        trailing: _renderText(quote.dayHigh)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Day Low', style: subtitleStyle),
        trailing: _renderText(quote.dayLow)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('52 WK High', style: subtitleStyle),
        trailing: _renderText(quote.yearHigh)
      ),

      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('52 WK Low', style: subtitleStyle),
        trailing: _renderText(quote.dayLow)
      ),
    ];
  }

  List<Widget> _rightColumn() {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Outstanding Shares', style: subtitleStyle),
        trailing: _renderText(quote.sharesOutstanding)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Volume', style: subtitleStyle),
        trailing: _renderText(quote.volume)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Avg Vol', style: subtitleStyle),
        trailing: _renderText(quote.avgVolume)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('MKT Cap', style: subtitleStyle),
        trailing: _renderText(quote.marketCap)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('P/E Ratio', style: subtitleStyle),
        trailing: _renderText(quote.pe)
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('EPS', style: subtitleStyle),
        trailing: _renderText(quote.eps)
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),

        const Text('Summary',style: kProfileScreenSectionTitle),
        const SizedBox(height: 8),

        Row(
          children: <Widget>[
            Expanded(
              child: Column(children: _leftColumn()),
            ),

            const SizedBox(width: 40),

            Expanded(
              child: Column(children: _rightColumn()),
            )
          ],
        ),
        const Divider(),

        

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('CEO', style: subtitleStyle),
          trailing: Text(displayDefaultTextIfNull(profile.ceo)),
        ),
        const Divider(),

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Sector', style: subtitleStyle),
          trailing: Text(displayDefaultTextIfNull(profile.sector)),
        ),
        const Divider(),

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Exchange', style: subtitleStyle),
          trailing: Text('${profile.exchange}'),
        ),
        const Divider(),

        Text('About ${profile.companyName ?? '-'} ',style: kProfileScreenSectionTitle),
        const SizedBox(height: 8),

        Text(profile.description ?? '-',
          style: const TextStyle(
            fontSize: 16,
            color: kLighterGray,
            height: 1.75
          ),
        ),
        const Divider(),
        
        const SizedBox(height: 30),
      ],
    );
  }
}